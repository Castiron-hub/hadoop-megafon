USE mf_goryacheva;
set hive.auto.convert.join=true;
set mapreduce.job.reduces=8;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_full_none logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_full_zlib logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_full_snappy logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_M_none logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_M_zlib logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_M_snappy logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_S_none logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_S_zlib logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;

SELECT
    logs.useragent,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs_optimized_S_snappy logs
JOIN users on users.ip = logs.ip
GROUP BY logs.useragent
LIMIT 10;