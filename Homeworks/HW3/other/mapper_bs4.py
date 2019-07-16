#!/opt/anaconda/envs/bd9/bin/python3
import re
import sys
from bs4 import BeautifulSoup


for line in sys.stdin:
    if line.strip().startswith('<row'):
        soup = BeautifulSoup(line,features='html') 
        try: tags = soup.select('row')[0].attrs['tags']
        except: tags = None
        try: creationdate = soup.select('row')[0].attrs['creationdate']
        except: creationdate = None
        
        if tags and creationdate:
            clean_tags = [re.sub('[<>]', '', k) for k in tags.split('><')]
            year = creationdate.split('T')[0].split('-')[0]
            for tag in clean_tags:
                print(year, '\t', tag, '\t', 1)