ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_goryacheva;
DROP TABLE IF EXISTS logs_raw;
CREATE EXTERNAL TABLE logs_raw (
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
LOCATION '/data/user_logs/user_logs_M';


DROP TABLE IF EXISTS users;
CREATE EXTERNAL TABLE users (
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
LOCATION '/data/user_logs/user_data_M';


DROP TABLE IF EXISTS ip_regions;
CREATE EXTERNAL TABLE ip_regions (
ip STRING,
region STRING
)
ROW FORMAT
serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties (
"input.regex" = "^(\\S*)\\t(.*)"
)
STORED AS textfile
LOCATION '/data/user_logs/ip_data_M';


DROP TABLE IF EXISTS logs;
CREATE EXTERNAL TABLE logs (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING);

set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE logs PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, substr(ts, 1,8) AS date
from logs_raw;

--SELECT count(distinct substr(ts, 1,8)) 
--FROM logs_raw LIMIT 10;

--SELECT * FROM users LIMIT 10;
--SELECT * FROM ip_regions LIMIT 10;
--SELECT * FROM logs_raw LIMIT 10;
--SELECT * FROM logs LIMIT 10;
