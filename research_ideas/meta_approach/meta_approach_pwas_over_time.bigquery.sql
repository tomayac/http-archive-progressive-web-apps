#standardSQL
SELECT
  DISTINCT date,
  COUNT(pwa_url) AS pwas
FROM (
  SELECT
    DISTINCT date,
    pwa_url
  FROM
    `progressive_web_apps.lighthouse_pwas`
  UNION ALL
  SELECT
    DISTINCT date,
    pwa_url
  FROM
    `progressive_web_apps.service_workers`
  UNION ALL
  SELECT
    DISTINCT date,
    pwa_url
  FROM
    `progressive_web_apps.usecounters_pwas`)
GROUP BY
  date
ORDER BY
  date;