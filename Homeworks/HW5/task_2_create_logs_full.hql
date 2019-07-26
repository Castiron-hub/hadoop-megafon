ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_goryacheva;
set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

DROP TABLE IF EXISTS users_full;
CREATE EXTERNAL TABLE users_full (
ip STRING,
useragent STRING,
gender STRING,
age INT
)
ROW FORMAT
serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties (
"input.regex" = "^(\\S*)\\t(\\S*)\\t(\\S*)\\t(\\d*).*"
)
STORED AS textfile
LOCATION '/data/user_logs/user_data';


DROP TABLE IF EXISTS logs_raw_full;
CREATE EXTERNAL TABLE logs_raw_full (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
ROW FORMAT
    serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
    with serdeproperties (
          "input.regex" = "^(\\S*)\\t\\t\\t(\\S*)\\t(\\S*)\\t(\\d*)\\t(\\d*)\\t(\\S*).*"
    )
STORED AS textfile
LOCATION '/data/user_logs/user_logs';

DROP TABLE IF EXISTS logs_full;
CREATE EXTERNAL TABLE logs_full (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING);


INSERT OVERWRITE TABLE logs_full PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, substr(ts, 1,8) AS date
from logs_raw_full;


DROP TABLE IF EXISTS logs_optimized_full;
CREATE EXTERNAL TABLE logs_optimized_full (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="ZLIB");

INSERT OVERWRITE TABLE logs_optimized_full PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_full;