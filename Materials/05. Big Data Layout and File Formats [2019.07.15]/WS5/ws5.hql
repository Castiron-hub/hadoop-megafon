1. ДЗ по Hive

USE mf_goryacheva; 
set hive.auto.convert.join=true;
set mapreduce.job.reduces=8;
SELECT 
    useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs 
JOIN users on users.ip = logs.ip
GROUP BY useragent
LIMIT 10;

2. Переложить данные logs в таблицу logs_optimized, где будет использоваться формат хранения данных ORC

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

dfs -du -s -h  /user/mf_goryacheva/hive/warehouse/logs;
2.2 M
dfs -du -s -h  /user/mf_goryacheva/hive/warehouse/logs_optimized;
NONE: 608.4 K  1.8 M
ZLIB: 289.7 K  869.2 K
SNAPPY: 390.6 K  1.1 M

ALTER TABLE logs_optimized SET TBLPROPERTIES ("orc.compress"="ZLIB");
