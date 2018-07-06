#standardSQL
SELECT
  date,
  count (DISTINCT pwa_url) AS total_pwas
FROM
  `progressive_web_apps.usecounters_pwas`
GROUP BY
  date
ORDER BY
  date;