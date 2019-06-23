#!/usr/bin/env python3
import sys

for line in sys.stdin:
    idx = line.split('\n')[0]
    print(str(hash(idx)) + '_' + idx)

