#standardSQL
  CREATE TABLE IF NOT EXISTS `progressive_web_apps.lighthouse_pwas` AS
SELECT
  DISTINCT url AS pwa_url,
  IFNULL(rank, 1000000) AS rank,
  date,
  platform,
  CAST(ROUND(score) AS INT64) AS lighthouse_pwa_score
FROM ( (
    SELECT
      REGEXP_REPLACE(JSON_EXTRACT(report, "$.url"), "\"", "") AS url,
      CAST(JSON_EXTRACT(report, "$.reportCategories[0].score") AS FLOAT64) AS score,
      REGEXP_REPLACE(REGEXP_EXTRACT(_TABLE_SUFFIX, "\\d{4}(?:_\\d{2}){2}"), "_", "-") AS date,
      REGEXP_EXTRACT(_TABLE_SUFFIX, ".*_(\\w+)$") AS platform
    FROM
      `httparchive.lighthouse.*`
    WHERE
      report IS NOT NULL
      AND JSON_EXTRACT(report, "$.audits.service-worker.score") = 'true'
      AND JSON_EXTRACT(report, "$.reportCategories[0].name") = '"Progressive Web App"' ) UNION ALL (
    SELECT
      REGEXP_REPLACE(JSON_EXTRACT(report, "$.url"), "\"", "") AS url,
      CAST(JSON_EXTRACT(report, "$.reportCategories[1].score") AS FLOAT64) AS score,
      REGEXP_REPLACE(REGEXP_EXTRACT(_TABLE_SUFFIX, "\\d{4}(?:_\\d{2}){2}"), "_", "-") AS date,
      REGEXP_EXTRACT(_TABLE_SUFFIX, ".*_(\\w+)$") AS platform
    FROM
      `httparchive.lighthouse.*`
    WHERE
      report IS NOT NULL
      AND JSON_EXTRACT(report, "$.audits.service-worker.score") = 'true'
      AND JSON_EXTRACT(report, "$.reportCategories[1].name") = '"Progressive Web App"' ))
LEFT JOIN (
  SELECT
    domain,
    rank
  FROM
    # Hard-coded due to https://github.com/HTTPArchive/bigquery/issues/42
    `httparchive.urls.20171221`
  WHERE
    rank IS NOT NULL
    AND domain IS NOT NULL ) AS urls
ON
  urls.domain = REGEXP_REPLACE(REGEXP_REPLACE(url, "https?:\\/\\/(?:www\\.)?", ""), "\\/$", "")
WHERE
  # Lighthouse "Good" threshold
  score >= 75
GROUP BY
  url,
  date,
  score,
  platform,
  date,
  rank
ORDER BY
  rank ASC,
  url,
  date DESC;