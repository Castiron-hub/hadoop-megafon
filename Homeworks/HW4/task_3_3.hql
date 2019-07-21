USE mf_goryacheva; 
set hive.auto.convert.join=true;
set mapreduce.job.reduces=8;
SELECT 
    response_code,
    SUM(IF(gender = 'male',1,0)) as male_count,
    SUM(IF(gender = 'female',1,0)) as female_count
FROM logs 
JOIN users on users.ip = logs.ip
GROUP BY response_code
LIMIT 10;
