CREATE STREAM swarm_journal_json(
  container STRUCT<id STRING, name STRING>, event STRUCT<created STRING>,
  host STRUCT<hostname STRING>,
  journald STRUCT<custom STRUCT<image_name STRING>>,
  log STRUCT<syslog STRUCT<facility_name STRING, priority INTEGER>>,
  message STRING,
  process STRUCT<name STRING>,
  syslog STRUCT<identifier STRING>,
  systemd STRUCT<transport STRING>)
WITH (KAFKA_TOPIC='swarm_journal_raw', VALUE_FORMAT='JSON');

CREATE STREAM swarm_journal_avro WITH (KAFKA_TOPIC='swarm_journal_avro',VALUE_FORMAT='AVRO') AS
SELECT * FROM swarm_journal_json;


select * from swarm_journal_avro WHERE journald->custom->image_name LIKE '%metricbeat%' AND SUBSTRING(message,1,1) = '{' EMIT CHANGES LIMIT 4;

CREATE STREAM swarm_journal_metricbeat WITH (KAFKA_TOPIC='swarm_journal_metricbeat',VALUE_FORMAT='AVRO') AS
SELECT host->hostname AS node, message AS json 
FROM swarm_journal_avro
WHERE journald->custom->image_name LIKE '%metricbeat%' AND SUBSTRING(message,1,1) = '{';
