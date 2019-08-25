USE mf_goryacheva;
set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;

DROP TABLE IF EXISTS logs_optimized_full_none;
CREATE EXTERNAL TABLE logs_optimized_full_none (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="NONE");

INSERT OVERWRITE TABLE logs_optimized_full_none PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_full;

DROP TABLE IF EXISTS logs_optimized_full_zlib;
CREATE EXTERNAL TABLE logs_optimized_full_zlib (
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

INSERT OVERWRITE TABLE logs_optimized_full_zlib PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_full;

DROP TABLE IF EXISTS logs_optimized_full_snappy;
CREATE EXTERNAL TABLE logs_optimized_full_snappy (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE logs_optimized_full_snappy PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_full;

DROP TABLE IF EXISTS logs_optimized_M_none;
CREATE EXTERNAL TABLE logs_optimized_M_none (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="NONE");

INSERT OVERWRITE TABLE logs_optimized_M_none PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_M;

DROP TABLE IF EXISTS logs_optimized_M_zlib;
CREATE EXTERNAL TABLE logs_optimized_M_zlib (
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

INSERT OVERWRITE TABLE logs_optimized_M_zlib PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_M;

DROP TABLE IF EXISTS logs_optimized_M_snappy;
CREATE EXTERNAL TABLE logs_optimized_M_snappy (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE logs_optimized_M_snappy PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_M;

DROP TABLE IF EXISTS logs_optimized_S_none;
CREATE EXTERNAL TABLE logs_optimized_S_none (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="NONE");

INSERT OVERWRITE TABLE logs_optimized_S_none PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_S;

DROP TABLE IF EXISTS logs_optimized_S_zlib;
CREATE EXTERNAL TABLE logs_optimized_S_zlib (
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

INSERT OVERWRITE TABLE logs_optimized_S_zlib PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_S;

DROP TABLE IF EXISTS logs_optimized_S_snappy;
CREATE EXTERNAL TABLE logs_optimized_S_snappy (
ip STRING,
ts STRING,
request STRING,
size INT,
response_code INT,
useragent STRING
)
PARTITIONED BY (date STRING)
STORED AS orc
    TBLPROPERTIES ("orc.compress"="SNAPPY");

INSERT OVERWRITE TABLE logs_optimized_S_snappy PARTITION(date)
SELECT ip, ts, request, size, response_code, useragent, date
from logs_S;
