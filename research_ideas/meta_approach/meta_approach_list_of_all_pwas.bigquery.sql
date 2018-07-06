#standardSQL
SELECT
  DISTINCT pwa_url,
  rank
FROM (
  SELECT
    DISTINCT pwa_url,
    rank
  FROM
    `progressive_web_apps.lighthouse_pwas` union all
  SELECT
    DISTINCT pwa_url,
    rank
  FROM
    `progressive_web_apps.service_workers` union all
  SELECT
    DISTINCT pwa_url,
    rank
  FROM
    `progressive_web_apps.usecounters_pwas`)
ORDER BY
  rank ASC;