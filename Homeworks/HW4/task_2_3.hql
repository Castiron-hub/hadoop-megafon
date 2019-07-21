USE mf_goryacheva;
SELECT count(*) as cnt, useragent 
FROM logs 
GROUP BY useragent
ORDER BY cnt desc
LIMIT 10;
