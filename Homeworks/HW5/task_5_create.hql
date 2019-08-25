USE mf_goryacheva;
set hive.exec.max.dynamic.partitions.pernode=116;
set hive.exec.dynamic.partition.mode=nonstrict;


DROP TABLE IF EXISTS logs_M_broken;
CREATE TABLE logs_M_broken AS
WITH t0 AS (
			SELECT ip, ts, request, size, response_code, useragent, row_number() rnk
			FROM logs_optimized_M
			)
SELECT * 
FROM


IF(useragent = 'Safari/5.0' or useragent = 'Firefox/5.0',useragent,'unknown') useragent 