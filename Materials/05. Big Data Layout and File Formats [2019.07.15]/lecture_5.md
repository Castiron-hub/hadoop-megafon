**Лекция 5**

1. Как правильно солить косые данные
2. Сжатие данных
3. Row форматы файлов 

Напоминание:
Select - стадия map
Where - стадия map
Group by - shuffle and sort
Having - reduce (т.к. после shuffle)
Join -  и map, и reduce
Order by/sort by - стадия reducer
- Order by - глобальная сортировка (все данные на один редьюсер)
- Sort by - сортировка данных на одном редьюсере


Dependence graph - сколько стадий осталось, как они связаны
The plans of each Stage - план выполнения запроса (любой запрос + EXPLAIN), до начала выполнения запроса


**Data Skew (данные с сильным перекосом)**

“Солим” данные, чтобы если много данных по одному ключу, они бы разъезжались на разные редьюсеры
- Делаем постфикс к null - случайное число => меняется значение кэша, данные разъезжаются на разные редьюсеры
- Дальше удаляем постфиксы и снова агрегируем

DoubleValueSum - reducer aggregate

**Data Skew в Hive**

SORT BY (или ON) 
DISTRIBUTE BY - отвечает за partitioner (что считаем ключем)  -  изменяет хэш, но не сам ключ CLUSTER BY - DISTRIBUTE BY + SORT BY (по умолчанию то же самое, отличается, если разные ключи для DISTRIBUTE и SORT) CLUSTERED BY - (INTO 256 buckets)
PARTITIONED BY - для фильтрации

_-ED - DDL (то есть указываются при создании таблиц)
Без ED - указываются в select_

при create table:
Set hive.mapred.supportes.subdirectories=true;
Или
SKEWED BY (user_id) ON (“unknown”,  “1”) 
STORED AS DIRECTORIES

**Сжатие данных**

Можно сжимать данные между фазами map и reduce.
No-splittable - кусок в gzip кусок можно читать только а рамках одного маппера
Lzo (?) и snappy - для горячих данных (хуже сжимают, но быстрее)


**Row форматы файлов**

ROW FORMAT DELIMITED
FIELDS TERMINATED BY
COLLECTOINS TERMINATETD BY

LATTERAL VIEW

STORED AS
TEXTFILE - стандартно
RCFile = Record Columnar File 
- Быстрая загрузка в хранилище
- Высокая скорость обработки запросов
- Эффективное использование жесткого диска
- Адаптивность к динамическому изменению паттернов аналитических запросов



























