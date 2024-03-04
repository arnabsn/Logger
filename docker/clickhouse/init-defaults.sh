#!/bin/bash

CLICKHOUSE_DB="servicenow";

#CLICKHOUSE_USER="${CLICKHOUSE_USER:-user}";
#CLICKHOUSE_PASSWORD="${CLICKHOUSE_PASSWORD:-password}";

clickhouse-client --query "CREATE DATABASE IF NOT EXISTS ${CLICKHOUSE_DB}";

echo -n 'CREATE TABLE IF NOT EXISTS syslog (
    sys_class_name VARCHAR(80) DEFAULT NULL,
    source VARCHAR(40) DEFAULT NULL,
    message MEDIUMTEXT DEFAULT NULL,
    level VARCHAR(40) DEFAULT NULL,
    source_package VARCHAR(32) DEFAULT NULL,
    source_application_family VARCHAR(32) DEFAULT NULL,
    context_map MEDIUMTEXT DEFAULT NULL,
    sys_id CHAR(32) NOT NULL,
    sys_created_by VARCHAR(40) DEFAULT NULL,
    sys_created_on DateTime,
    host_name VARCHAR(40)
) 
ENGINE = MergeTree()
PARTITION BY toStartOfHour(sys_created_on)
ORDER BY (sys_created_on)
SETTINGS index_granularity = 8192
;' | clickhouse-client
