# Задание 1 

sqoop import \
 --connect "jdbc:mysql://virtual-client:3306/moon_db" \
 --username sqoop \
 --password sqoop \
 --table person \
 --target-dir /user/sgrishko00/sqoop_test_data/person_(date +%Y%m%d%H%M)

# Задание 2 

sqoop import \
 --connect "jdbc:mysql://virtual-client:3306/moon_db" \
 --username sqoop \
 --password sqoop \
 --table person_details \
 --target-dir /user/sgrishko00/sqoop_test_data/person_$(date +%Y%m%d%H%M) \
 --num-mappers 1 \
 --hive-import \
 --null-string '\\N' \
 --null-non-string '\\N' \
 --hive-overwrite \
 --hive-table sqoop_db.person_gsi \
 --hive-drop-import-delims

 # Задание 3

sqoop import \
 --connect "jdbc:mysql://virtual-client:3306/moon_db" \
 --username sqoop \
 --password sqoop \
 --table person_export \
 --target-dir /user/sgrishko00/sqoop_test_data/person_export_1 \
 --num-mappers 1 \
 --fields-terminated-by ','\
 --hive-import \
 --null-string '\\N' \
 --null-non-string '\\N' \
 --hive-overwrite \
 --hive-table sqoop_db.person_export \
 --hive-drop-import-delims


  sqoop export \
 --connect "jdbc:mysql://virtual-client:3306/moon_db" \
 --username sqoop \
 --password sqoop \
 --table person_export \
 --null-string '\\N' \
 --null-non-string '\\N' \
 --input-fields-terminated-by ',' \
 --num-mappers 1 \
 --export-dir  /user/hive/warehouse/sqoop_db.db/person_export/
