## Описание

1. **movielens_ddl.cql** - файл, в котором содержаться команды создания keyspace, таблиц и индексов 
2. **spark_cassandra.ipynb** - ноутбук, в котором написан Spark SQL код
3. **movielens.cql** - файл, в котором содержатся запросы, отвечающие на поставленные вопросы
4. **hw11.ipynb** - общий ноутбук с кодом, там все подряд

## Порядок запуска скриптов:
1. Запустить cqlsh:
```mf_goryacheva@virtual-client:~/HW11$ cqlsh virtual-node01```
2. Запустить **movielens_ddl.cql**
```cqlsh> SOURCE '~/HW11/movielens_ddl.cql'```
3. Выполнить ноутбук **spark_cassandra.ipynb**
4. Запустить **movielens.cql**
```cqlsh> SOURCE '~/HW11/movielens.cql'```
