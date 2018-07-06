#standardSQL
SELECT
  DISTINCT pwa_url,
  sw_url,
  date,
  CHAR_LENGTH(body) AS sw_length
FROM
  `progressive_web_apps.service_workers`
JOIN
  `httparchive.response_bodies.*`
ON
  sw_url = url
  AND date = REGEXP_REPLACE(REGEXP_EXTRACT(_TABLE_SUFFIX, "\\d{4}(?:_\\d{2}){2}"), "_", "-")
  AND platform = REGEXP_EXTRACT(_TABLE_SUFFIX, ".*_(\\w+)$")
WHERE
  # Redacted
  pwa_url = "https://example.com/"
  AND platform = "mobile"
ORDER BY
  date ASC;