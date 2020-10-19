# `swarm.g1` - ModEco

The swarm monitoring module, generation 2.
See `conteco.docs.overview` for more information on the ModEco ecosystem.

The main package contains Kafka, KSQL Server StreamSets and the EKG ElasticSearch stack.

## Structure

The module consists of the following service stacks:

 * ekg - ElasticSearch, Grafana and Kibana
 * kz - Kafka and Zookeeper
 * ksql - KSQL Server
 * ss_processor - StreamSets general purpose stream processor, from Kafka to Kafka
 * ss_export - StreamSets Kafka to ElasticSearch exporter
 * node_logs - node log file monitoring
 * container_logs - container log file monitoring
 * container_settings - container settings monitoring
 * ss_processor_ui - Nginx to expose the UI of the processor StreamSets instance
 * ss_export_ui - Nginx to expose the UI of the export StreamSets instance
 * grafana - Nginx to expose Grafana on /elk/grafana
 * kibana - Nginx to expose Kibana on /elk/kibana
