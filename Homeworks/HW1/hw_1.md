# MF-BD-2019-Q2
## HW #01: HDFS proficiency
[Все команды hdfs](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/FileSystemShell.html)
### Beginner
**Задание 1.1**  
Пробросить порт (port forwarding) для доступа к HDFS Web UI  
  
**Команда:**  
`ssh mf_goryacheva@virtual-client.bigdatateam.ru -L 50070:virtual-master:50070`  
`password:` из письма  
Доступ к HDFS Web UI: http://localhost:50070/​  
***
**Задание 1.2**  
[1 балл] Воспользоваться Web UI для того, чтобы найти папку “/data” в HDFS, а в ней логи какого-то сервиса (см. “access_log”). Сколько папок и файлов в указанной папке с логами?

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -ls /data/access_logs | wc -l`  
**Ответ:**
9
***
### Intermediate
**Задание 2.1**  
[3 балла] Вывести рекурсивно список всех файлов в /data/wiki

**Команда:**  

`mf_goryacheva@virtual-client:~$ hdfs dfs -ls -R /data/wiki`  
  
**Ответ:**  
drwxr-xr-x   - hdfs supergroup          0 2017-09-17 15:52 /data/wiki/en_articles  
-rw-r--r--   3 hdfs supergroup 12328051927 2017-09-17 15:52 /data/wiki/en_articles/articles  
drwxr-xr-x   - hdfs supergroup           0 2017-09-17 13:10 /data/wiki/en_articles_part  
-rw-r--r--   3 hdfs supergroup    76861985 2017-09-17 13:10 /data/wiki/en_articles_part/articles-part  
drwxr-xr-x   - hdfs supergroup           0 2017-09-17 12:47 /data/wiki/en_articles_part1  
-rw-r--r--   3 hdfs supergroup    76861985 2017-09-17 12:47 /data/wiki/en_articles_part1/articles-part  
-rw-r--r--   3 hdfs supergroup        1914 2017-09-17 10:16 /data/wiki/stop_words_en-xpo6.txt  
***
**Задание 2.2**  
 3 балла] См. п.1 + вывести размер файлов в “human readable” формате (т.е. не в
байтах, а например в МБ, когда размер файла измеряется от 1 до 1024 МБ).  

**Команда:**  

`mf_goryacheva@virtual-client:~$ hdfs dfs -ls -h -R /data/wiki`   

**Ответ:**  
drwxr-xr-x   - hdfs supergroup          0 2017-09-17 15:52 /data/wiki/en_articles  
-rw-r--r--   3 hdfs supergroup      11.5 G 2017-09-17 15:52 /data/wiki/en_articles/articles  
drwxr-xr-x   - hdfs supergroup           0 2017-09-17 13:10 /data/wiki/en_articles_part  
-rw-r--r--   3 hdfs supergroup      73.3 M 2017-09-17 13:10 /data/wiki/en_articles_part/articles-part  
drwxr-xr-x   - hdfs supergroup           0 2017-09-17 12:47 /data/wiki/en_articles_part1  
-rw-r--r--   3 hdfs supergroup      73.3 M 2017-09-17 12:47 /data/wiki/en_articles_part1/articles-part  
-rw-r--r--   3 hdfs supergroup       1.9 K 2017-09-17 10:16 /data/wiki/stop_words_en-xpo6.txt  
***
**Задание 2.3**   
[3 балла] Ответьте на вопрос: какой фактор репликации используется для файлов
и папок?

**Ответ:**  3 (см. ответ выше) для файлов и 0 для папок  

***
**Задание 2.4**  
[3 балла] Ответьте на вопрос: полученный выводе размер файла - это актуальный
размер файла или же объем пространства, занимаемый с учетом всех реплик
этого файла?

**Ответ:** Актуальный размер
***
**Задание 2.5**  
[3 балла] Получите размер пространства, занимаемый всеми файлами (с учетом
рекурсии) внутри /data/wiki (т.е. на выходе ожидается одно число / одна строка)

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -du -s -h /data/wiki`  

**Ответ:** 34.9 G
***
**Задание 2.6**  
[3 балла] Создайте папку в домашней HDFS-папке Вашего пользователя, чтобы
избежать конфликтов, на всякий случай используйте Ваш id (см. grades) в качестве
префикса папки.  

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -mkdir 5_tonya`
***
**Задание 2.7**  
[3 балла] Создайте вложенную структуру из папок одним вызовом CLI.

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -mkdir -p 5_tonya/5_tonya_1/5_tonya_2`  
***
**Задание 2.8**  
[3 балла] Удалите созданные папки рекурсивно.

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -rm -r -f 5_tonya` 
***
**Задание 2.9**  
[3 балла] Что такое Trash в распределенной FS? Как сделать так, чтобы файлы
удалялись сразу, минуя “Trash”?

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -rm -r -f -skipTrash 5_tonya`  
  
**Ответ:** 
- Trash в распределенной FS помогает предотвратить случайное удаление файлов и каталогов.   
При удалении файла в HDFS, файл не сразу удаляется из HDFS, а попадает в корзину (Trash).  
- Параметр `-skipTrash` позволяет удалять файлы минуя корзину.
***
**Задание 2.10**  
[3 балла] Создайте пустой файл в HDFS

**Команда:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -touchz tg_file`  
***
**Задание 2.11**  
[3 балла] Создайте небольшой произвольный файл (идеально - 15 строчек по 100
байт) и загрузите файл из локальной файловой системы (local FS) в HDFS.

**Команды:**  
`mf_goryacheva@virtual-client:~$ nano tg_file`  
Edit file, save and close 
`mf_goryacheva@virtual-client:~$ hdfs dfs -put ./tg_file`  
***
**Задание 2.12**  
[3 балла] Выведите HDFS-файл, его начало и конец (аналог консольных утилит -
cat / head/ tail).  
  
**Команды:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -cat tg_file`  
`mf_goryacheva@virtual-client:~$ hdfs dfs -cat tg_file | head`  
`mf_goryacheva@virtual-client:~$ hdfs dfs -tail tg_file` 
***
**Задание 2.13**  
[3 балла] В чем разница между HDFS флагом “-tail” и локальной утилитой “tail”?
Каким образом воспроизвести поведение “-tail” локально?

**Ответ:** 
- `hdfs dfs -tail` выводит последний килобайт файла, а локальный `tail` выводит последние 5 строк (по умолчанию).
-  Команда для воспроизведения `-tail` локально: `tail --bytes=1024 tg_file`  
***
**Задание 2.14**  
[3 балла] Сделайте копию файла в HDFS и переместите его на новую локацию
(аналог консольных утилит - cp, mv)  
  
**Команды:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -cp tg_file tg_file_cp`  
`mf_goryacheva@virtual-client:~$ hdfs dfs -mkdir temp`  
`mf_goryacheva@virtual-client:~$ hdfs dfs -mv tg_file_cp temp`  
***
**Задание 2.15**  
[3 балла] Загрузите HDFS-файлы локально, а также объедините их в один файл
при загрузке.  
  
**Команды:**  
`mf_goryacheva@virtual-client:~$ hdfs dfs -get temp/tg_file_cp`  
`mf_goryacheva@virtual-client:~$ hdfs dfs -get tg_file`  
`mf_goryacheva@virtual-client:~$ hdfs dfs -getmerge temp/tg_file_cp tg_file tg_file_merge`  
***
### Advanced  
**Задание 3.1**  
[6 баллов] ​ Изменить replication factor для файла. Как долго занимает время на
увеличение / уменьшение числа реплик для файла?  
  
**Команды:** 
- Увеличение с 3 до 4:   
`time hdfs dfs -setrep -w 4 tg_file`  
Output:  
`Replication 4 set: tg_file`  
`Waiting for tg_file .... done`   
`real	0m11.986s`  
`user	0m3.604s`  
`sys	0m0.124s`  
- Уменьшение с 4 до 2:  
`time hdfs dfs -setrep -w 2 tg_file`  
Output:  
`WARNING: the waiting time may be long for DECREASING the number of replications.
.. done`  
`real	0m21.945s`  
`user	0m3.456s`  
`sys	0m0.104s`  
***
**Задание 3.2**  
[6 баллов] ​ Найдите информацию по файлу и блокам с помощью “hdfs fsck” CLI   
  
**Команда:**   
`mf_goryacheva@virtual-client:~$ hdfs fsck /data/wiki/en_articles -files -blocks`  

**Ответ:**  
 `Total files:	1`   
 `Total blocks (validated):	92 (avg. block size 134000564 B)`  

***
**Задание 3.3**  
[6 баллов] ​ Получите информацию по любому блоку из п.2 с помощью "hdfs fsck
-blockId”. Обратите внимание на Generation Stamp (GS number).  
   
**Команда:**   
`mf_goryacheva@virtual-client:~$ hdfs fsck -blockId blk_1073762231`  
  
**Ответ:**  
`Block Id: blk_1073762231`  
`Block belongs to: /data/wiki/en_articles/articles`  
***
**Задание 3.4**  
[6 баллов] ​ Воспользуйтесь пользователем hdfsuser, чтобы найти физические
реплики на Datanode’ах и исследовать файловую структуру Namenode (e.g.
edits.log)  
  
**Команды:**   
`mf_goryacheva@virtual-client:~$ sudo -i -u hdfsuser`  
`hdfsuser@virtual-client:~$ hdfs fsck /data/wiki/en_articles -files -blocks -locations`
Видно например для блока 91:  
91. BP-239676197-136.243.56.207-1505242879565:blk_1073762231_21407 len=114238679 Live_repl=3   
[DatanodeInfoWithStorage[148.251.47.79:50010,DS-91697283-f49e-45e1-83ef-3d0a30850765,DISK],   
DatanodeInfoWithStorage[78.46.69.109:50010,DS-62d7c47a-9a3c-4298-b584-21db6c893280,DISK],   
DatanodeInfoWithStorage[5.9.115.228:50010,DS-72764a13-41c7-4d74-8d09-5e299387c6f4,DISK]] . 
Посмотрим на реплику DS-91697283-f49e-45e1-83ef-3d0a30850765,  она находится на 148.251.47.79:50010 (virtual-node03.bigdatateam.ru) 
***
### Задания по WebHDFS

[Документация](https://hadoop.apache.org/docs/r1.0.4/webhdfs.html)  

**Задание 4.1**  
[6 баллов] ​ Получить данные файла размером в 100B.  
  
**Команды:**  
- Cоздаем файл размером 100B:    
   `python -c 'with open("100B_file", "w") as f: f.write("a"*100)'`
- Перекидываем на hdfs:  
`hdfs dfs -put 100B_file`
- Считываем:   
`curl -i "http://virtual-master:50070/webhdfs/v1/user/mf_goryacheva/100B_file?op=OPEN"`
***
**Задание 4.2**  
[6 баллов] ​ Научиться пользоваться опцией “follow redirects” с помощью curl (см.
“man curl”).  
  
**Команда:**  
`curl -L "http://virtual-master:50070/webhdfs/v1/user/mf_goryacheva/100B_file?op=OPEN"`  

***
**Задание 4.3**  
[6 баллов] ​ Получить детализированную информацию по файлу (см. file status)   

**Командa:**  
`curl -i "http://virtual-master:50070/webhdfs/v1/user/mf_goryacheva/100B_file?op=GETFILESTATUS"`  
***
**Задание 4.4**  
[6 баллов] ​ Изменить параметр репликации файла с помощью curl  

**Командa:**    
`curl -i -X PUT "http://virtual-master:50070/webhdfs/v1/user/mf_goryacheva/100B_file?user.name=mf_goryacheva&op=SETREPLICATION&replication=5"`

**Задание 4.5**  
[6 баллов] ​ Дозаписать данные в файл (append). Подсказка - обратите внимание,
что это запрос типа “POST”.  

**Команды:**  

- Создаем новый файл  
`python -c 'with open("appendix", "w") as f: f.write("b"*10)'`  
`hdfs dfs -put appendix`
- Шаг 1    
`curl -i -X POST "http://virtual-master:50070/webhdfs/v1/user/mf_goryacheva/100B_file?op=APPEND&buffersize=10"`
- Шаг 2 (см locations в предыдушем запросе)    
`curl -i -X POST -T appendix "http://virtual-node02.bigdatateam.ru:50075/webhdfs/v1/user/mf_goryacheva/100B_file?op=APPEND&user.name=mf_goryacheva&namenoderpcaddress=virtual-master.bigdatateam.ru:8020&buffersize=10"`  


