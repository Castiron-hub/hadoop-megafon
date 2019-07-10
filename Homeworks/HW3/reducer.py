#!/opt/anaconda/envs/bd9/bin/python3
import sys

def top10(arr, good_year, real_year, tag, value):
    if int(real_year) == good_year:
        arr.append((real_year, tag, value))
        arr = sorted(arr, key=lambda x: x[2], reverse=True)
        arr = arr[:10]
    return arr

prev_key = None
value_sum = 0

YEAR_1 = 2010
YEAR_2 = 2016
top_year1 = []
top_year2 = []


for line in sys.stdin:
    year, tag, value = line.strip().split('\t', 2)
    key = str(year) + '\t' + str(tag)
    value = int(value)
    if key != prev_key and prev_key is not None:
        top_year1 = top10(top_year1, YEAR_1, year, tag, value_sum)
        top_year2 = top10(top_year2, YEAR_2, year, tag, value_sum)
        #print(prev_key+'\t'+str(value_sum))
        value_sum = 0
        

    prev_key = key
    value_sum += value
if prev_key is not None:
    #print(prev_key+'\t'+str(value_sum))
    top_year1 = top10(top_year1, YEAR_1, year, tag, value_sum)
    top_year2 = top10(top_year2, YEAR_2, year, tag, value_sum)

for row in top_year1:
    print(row[0],'\t', row[1], '\t', row[2])
for row in top_year2:
    print(row[0],'\t', row[1], '\t', row[2])
