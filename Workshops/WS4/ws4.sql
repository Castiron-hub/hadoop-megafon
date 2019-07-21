--WORKSHOP

1. Создание БД

create database mf_goryacheva location '/user/mf_goryacheva/hive/warehouse'; --путь должен быть абсолютным
describe database mf_goryacheva;
drop database if exists mf_goryacheva;

2. Создание Managed таблиц

2.1. hdfs dfs -mkdir hive_practice_data;
2.2. hdfs dfs -put /home/aadral/public_examples/hive/tab_delimited.txt /user/mf_goryacheva/hive_practice_data/

2.3. Создать файл create_tab_table.hql:

USE mf_goryacheva;
DROP TABLE IF EXISTS tab_dataset;
CREATE EXTERNAL TABLE tab_dataset (
      first_column STRING,
      second_column STRING,
      value INT
)ROW FORMAT DELIMITED
    FIELDS TERMINATED BY '\t'
LOCATION '/user/mf_goryacheva/hive_practice_data/';

2.4. hive -f create_tab_table.hql
2.5. hive -e "use mf_goryacheva; select * from tab_dataset;"
2.6. DESCRIBE FORMATTED tab_dataset

3. Пример создания Hive-таблицы (с пояснениями)

--подключение к базе данных. Без этой строки таблицы будут создаваться в базе "default".
USE mf_goryacheva;
DROP TABLE IF EXISTS subnets;
--существует 2 типа таблиц: MANAGED и EXTERNAL. EXTERNAL таблицы работают с внешними данными не изменяя их, а MANAGED позволяют их изменять
CREATE EXTERNAL TABLE subnets (
    ip STRING, mask STRING 
)ROW FORMAT DELIMITED
    FIELDS TERMINATED BY '\t'
--формат хранения таблицы. Для EXTERNAL таблиц формат должен совпадать с форматом хранения данных. Для MANAGED рекомендуется использовать сжатые форматы хранения (RCFile, ORC, AVRO и т.п.).
STORED AS TEXTFILE
LOCATION '/data/subnets/variant1';

select * from subnets limit 10;

4. Создание таблиц на основе Regexp.

--V1
ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE mf_goryacheva;
DROP TABLE IF EXISTS ser_de_example;
CREATE EXTERNAL TABLE ser_de_example (
    ip STRING
)
ROW FORMAT
    serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
    with serdeproperties (
          "input.regex" = "^(\\S*)\\t.*"
    )
STORED AS textfile
LOCATION '/data/user_logs/user_logs_M';
SELECT * FROM ser_de_example LIMIT 10;


--V2
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
SELECT * FROM logs_raw LIMIT 10;


4.1. Задача 0​. Посчитать количество различных масок подсети.
select count(distinct ip) from ser_de_example;
--17

4.2. Задача 1​. Посчитать количество адресов, имеющих маску 255.255.255.128.

select count(1)   
from mf_goryacheva.ser_de_example t
group by ip
having ip = '255.255.255.128';
--0

4.3. Задача 2​. Посчитать среднее количество адресов по маскам.

with t0 as (
select count(1) cnt, ip
from mf_goryacheva.ser_de_example t
group by ip)
select avg(cnt)
from t0;
--593.6470588235294














