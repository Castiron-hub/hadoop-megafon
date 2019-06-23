#!/usr/bin/env bash
set -x

HADOOP_STREAMING_JAR="/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar"
HDFS_OUTPUT_DIR=hw2_mr_data_ids

hdfs dfs -rm -r -skipTrash $HDFS_OUTPUT_DIR

yarn jar $HADOOP_STREAMING_JAR \
        -files mapper.py,reducer.py \
        -mapper 'python3 mapper.py' \
        -reducer 'python3 reducer.py' \
        -input /data/ids \
        -output $HDFS_OUTPUT_DIR

hdfs dfs -cat $HDFS_OUTPUT_DIR/*  | head -n 50
hdfs dfs -cat $HDFS_OUTPUT_DIR/*  | head -n 50 > hw2_mr_data_ids.out

echo $?
