-- Argos MVP database schema (Supabase PostgreSQL) - full snapshot v1.0.0
-- Idempotent: safe to run on an empty database and re-runnable where IF NOT EXISTS applies.
--
-- Conventions (see db-design-choices.md):
--   * Server-only `id bigint GENERATED ALWAYS AS IDENTITY` is the primary key for indexing/ordering only.
--     It never leaves the server and is never used as a foreign key.
--   * `uuid` is the global identity for every row (minted by the creating client where applicable).
--   * Relationships use `*_uuid` columns (not integer ids). Server foreign-key constraints are omitted
--     for sync tolerance unless both sides are always written online in order.
--   * Soft deletes use `archived_at`; normal reads gate on `archived_at IS NULL`.
--   * `updated_at` is the change column for synchronization/conflict resolution.
--   * Attribution/action actor columns (e.g. created_by, actor_uuid) are server-stamped in application logic.

BEGIN;

-- Extensions
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- -----------------------------------------------------------------------------
-- app_user: authenticated app accounts and roles (A-D). Guests have no row.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.app_user (
  id           bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  uuid         uuid NOT NULL, -- account identity (e.g. Supabase auth.users.id)
  role         text NOT NULL,
  display_name text,
  created_at   timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now(),
  archived_at  timestamptz,
  CONSTRAINT app_user_pkey PRIMARY KEY (id),
  CONSTRAINT app_user_uuid_key UNIQUE (uuid),
  CONSTRAINT app_user_role_check CHECK (role IN ('system_admin', 'admin', 'moderator', 'commuter'))
);

CREATE INDEX IF NOT EXISTS idx_app_user_role_live
  ON public.app_user (role)
  WHERE archived_at IS NULL;

-- -----------------------------------------------------------------------------
-- sighting: anonymous, approximate, short-lived PUV proximity report.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.sighting (
  id              bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  uuid            uuid NOT NULL,
  created_by      uuid, -- reporter account uuid; stored for accountability, never exposed publicly
  approx_lat      numeric(9, 6) NOT NULL,
  approx_lng      numeric(9, 6) NOT NULL,
  spotted_at      timestamptz NOT NULL,
  expires_at      timestamptz NOT NULL,
  retention_until timestamptz NOT NULL,
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now(),
  archived_at     timestamptz, -- hidden/removed by moderation or lifecycle handling
  CONSTRAINT sighting_pkey PRIMARY KEY (id),
  CONSTRAINT sighting_uuid_key UNIQUE (uuid),
  CONSTRAINT sighting_lat_check CHECK (approx_lat >= -90 AND approx_lat <= 90),
  CONSTRAINT sighting_lng_check CHECK (approx_lng >= -180 AND approx_lng <= 180),
  CONSTRAINT sighting_expiry_check CHECK (expires_at >= spotted_at),
  CONSTRAINT sighting_retention_check CHECK (retention_until >= expires_at)
);

CREATE INDEX IF NOT EXISTS idx_sighting_active_time
  ON public.sighting (expires_at, archived_at);

CREATE INDEX IF NOT EXISTS idx_sighting_spotted_at
  ON public.sighting (spotted_at);

CREATE INDEX IF NOT EXISTS idx_sighting_approx_location
  ON public.sighting (approx_lat, approx_lng);

CREATE INDEX IF NOT EXISTS idx_sighting_created_by
  ON public.sighting (created_by);

-- -----------------------------------------------------------------------------
-- sighting_confirmation: signed-in commuter confirms a sighting is still present.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.sighting_confirmation (
  id           bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  uuid         uuid NOT NULL,
  sighting_uuid uuid NOT NULL,
  created_by   uuid, -- confirmer account uuid
  created_at   timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now(),
  archived_at  timestamptz,
  CONSTRAINT sighting_confirmation_pkey PRIMARY KEY (id),
  CONSTRAINT sighting_confirmation_uuid_key UNIQUE (uuid)
);

CREATE INDEX IF NOT EXISTS idx_sighting_confirmation_sighting
  ON public.sighting_confirmation (sighting_uuid);

CREATE INDEX IF NOT EXISTS idx_sighting_confirmation_created_by
  ON public.sighting_confirmation (created_by);

-- One live confirmation per user per sighting.
CREATE UNIQUE INDEX IF NOT EXISTS idx_sighting_confirmation_live_unique
  ON public.sighting_confirmation (sighting_uuid, created_by)
  WHERE archived_at IS NULL;

-- -----------------------------------------------------------------------------
-- sighting_flag: report a false, abusive, or misleading sighting for review.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.sighting_flag (
  id            bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  uuid          uuid NOT NULL,
  sighting_uuid uuid NOT NULL,
  created_by    uuid, -- flagger account uuid
  reason        text,
  status        text NOT NULL DEFAULT 'pending',
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  archived_at   timestamptz,
  CONSTRAINT sighting_flag_pkey PRIMARY KEY (id),
  CONSTRAINT sighting_flag_uuid_key UNIQUE (uuid),
  CONSTRAINT sighting_flag_status_check CHECK (status IN ('pending', 'dismissed', 'actioned'))
);

CREATE INDEX IF NOT EXISTS idx_sighting_flag_sighting
  ON public.sighting_flag (sighting_uuid);

CREATE INDEX IF NOT EXISTS idx_sighting_flag_status_live
  ON public.sighting_flag (status)
  WHERE archived_at IS NULL;

CREATE INDEX IF NOT EXISTS idx_sighting_flag_created_by
  ON public.sighting_flag (created_by);

-- -----------------------------------------------------------------------------
-- moderation_action: moderator/admin actions on flags or sightings.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.moderation_action (
  id               bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  uuid             uuid NOT NULL,
  sighting_uuid    uuid,
  flag_uuid        uuid,
  actor_uuid       uuid, -- moderator/admin account uuid
  target_user_uuid uuid, -- e.g. sighting reporter for guideline hits
  action_type      text NOT NULL,
  notes            text,
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now(),
  archived_at      timestamptz,
  CONSTRAINT moderation_action_pkey PRIMARY KEY (id),
  CONSTRAINT moderation_action_uuid_key UNIQUE (uuid),
  CONSTRAINT moderation_action_type_check CHECK (
    action_type IN ('dismiss_flag', 'hide_sighting', 'remove_sighting', 'guideline_hit')
  )
);

CREATE INDEX IF NOT EXISTS idx_moderation_action_sighting
  ON public.moderation_action (sighting_uuid);

CREATE INDEX IF NOT EXISTS idx_moderation_action_flag
  ON public.moderation_action (flag_uuid);

CREATE INDEX IF NOT EXISTS idx_moderation_action_actor
  ON public.moderation_action (actor_uuid);

CREATE INDEX IF NOT EXISTS idx_moderation_action_target_user
  ON public.moderation_action (target_user_uuid);

-- -----------------------------------------------------------------------------
-- app_setting: essential system parameters (expiry, radius, threshold, retention, etc.).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.app_setting (
  id            bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  uuid          uuid NOT NULL,
  setting_key   text NOT NULL,
  setting_value text NOT NULL,
  description   text,
  updated_by    uuid, -- authorized account uuid
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  archived_at   timestamptz,
  CONSTRAINT app_setting_pkey PRIMARY KEY (id),
  CONSTRAINT app_setting_uuid_key UNIQUE (uuid)
);

-- One live value per setting key.
CREATE UNIQUE INDEX IF NOT EXISTS idx_app_setting_key_live
  ON public.app_setting (setting_key)
  WHERE archived_at IS NULL;

-- Seed essential MVP setting keys (values are placeholders/defaults; adjust per deployment).
INSERT INTO public.app_setting (uuid, setting_key, setting_value, description)
VALUES
  (gen_random_uuid(), 'sighting_expiry_minutes', '15', 'Duration in minutes before a sighting expires'),
  (gen_random_uuid(), 'proximity_radius_m', '1000', 'Default proximity radius in meters for nearby alerts'),
  (gen_random_uuid(), 'aggregation_threshold', '2', 'Minimum confirmations/reports required for broad visibility'),
  (gen_random_uuid(), 'retention_limit_hours', '24', 'Hours after which expired sightings may be permanently deleted')
ON CONFLICT (setting_key) WHERE archived_at IS NULL DO NOTHING;

COMMIT;
