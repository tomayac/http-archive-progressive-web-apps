#standardSQL
SELECT
  date,
  COUNT(IF (install_event,
      TRUE,
      NULL)) AS install_events,
  COUNT(IF ( activate_event,
      TRUE,
      NULL)) AS activate_events,
  COUNT(IF ( fetch_event,
      TRUE,
      NULL)) AS fetch_events,
  COUNT(IF ( push_event,
      TRUE,
      NULL)) AS push_events,
  COUNT(IF ( notificationclick_event,
      TRUE,
      NULL)) AS notificationclick_events,
  COUNT(IF ( notificationclose_event,
      TRUE,
      NULL)) AS notificationclose_events,
  COUNT(IF ( sync_event,
      TRUE,
      NULL)) AS sync_events,
  COUNT(IF ( canmakepayment_event,
      TRUE,
      NULL)) AS canmakepayment_events,
  COUNT(IF ( paymentrequest_event,
      TRUE,
      NULL)) AS paymentrequest_events,
  COUNT(IF ( message_event,
      TRUE,
      NULL)) AS message_events,
  COUNT(IF ( messageerror_event,
      TRUE,
      NULL)) AS messageerror_events
FROM
  `progressive_web_apps.service_workers`
WHERE
  NOT uses_workboxjs
  AND date LIKE "2018-%"
GROUP BY
  date
ORDER BY
  date;