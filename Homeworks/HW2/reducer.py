#!/usr/bin/env python3
import sys
import random 

n = random.randint(1, 5)
output = []

for line in sys.stdin:
    key = line.split('\n')[0]
    prefix, idx = key.split('_')    
    
    if len(output) < n:
        output.append(idx)
    else:
        print(','.join(output))
        output = []
        output.append(idx)
        n = random.randint(1, 5)

if len(output) <= n:
    print(','.join(output))

