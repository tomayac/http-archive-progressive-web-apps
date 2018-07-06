#standardSQL
SELECT
  date,
  count (DISTINCT pwa_url) AS total_pwas,
  round(AVG(lighthouse_pwa_score), 1) AS avg_lighthouse_pwa_score
FROM
  `progressive_web_apps.lighthouse_pwas`
GROUP BY
  date
ORDER BY
  date;