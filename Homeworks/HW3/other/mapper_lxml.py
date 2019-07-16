#!/opt/anaconda/envs/bd9/bin/python3
import re
import sys
from lxml import etree

for line in sys.stdin:
    try:
        row = etree.XML(s)
        try: tags = [value for tag, value in row.items() if tag == 'Tags'][0]
        except: tags = None
        try: creationdate = [value for tag, value in row.items() if tag == 'CreationDate'][0]
        except: creationdate = None
        if tags and creationdate:
            clean_tags = [re.sub('[<>]', '', k) for k in tags.split('><')]
            year = creationdate.split('T')[0].split('-')[0]
            for tag in clean_tags:
                print(year, '\t', tag, '\t', 1)
    except:
        pass