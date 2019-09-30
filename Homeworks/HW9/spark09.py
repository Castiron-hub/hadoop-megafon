from pyspark import SparkContext
from pyspark.streaming import StreamingContext

sc = SparkContext(master='local[2]')
ssc = StreamingContext(sc, batchDuration=10)
ssc.checkpoint("_temp")

def ls(directory):
     hadoop = sc._jvm.org.apache.hadoop
     fs = hadoop.fs.FileSystem
     conf = hadoop.conf.Configuration()
     path = hadoop.fs.Path(directory)
     return [f.getPath() for f in fs.get(conf).listStatus(path)]

def cum_sum(new_values, old_value):
    return (old_value or 0) + sum(new_values)

ls_result = ls('/data/course4/uid_ua_100k_splitted_by_5k')

batches = [sc.textFile(f) for f in map(str, ls_result)]
dstream = ssc.queueStream(rdds=batches)

result = dstream.filter(bool) \
		.map(lambda x: (x.split('\t')[1], 1)) \
		.reduceByKey(lambda x, y: x + y) \
		.updateStateByKey(cum_sum) \
		.transform(lambda rdd: rdd.sortBy(lambda x: x[1], ascending=False)) \
		.map(lambda x: '{}\t{}'.format(x[1], x[0]))

result.pprint(10)

ssc.start()
ssc.awaitTermination()