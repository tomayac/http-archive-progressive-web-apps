#standardSQL
SELECT
  DISTINCT pwa_url,
  manifest_url
FROM
  `progressive_web_apps.web_app_manifests`
WHERE
  gcm_sender_id_property;