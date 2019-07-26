USE mf_goryacheva; 
set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;
DROP TABLE IF EXISTS logs_optimized;
CREATE EXTERNAL TABLE logs_optimized (
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


INSERT OVERWRITE TABLE logs_optimized PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs;