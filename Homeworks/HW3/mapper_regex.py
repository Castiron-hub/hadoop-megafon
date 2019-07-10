#!/opt/anaconda/envs/bd9/bin/python3
import re
import sys

pattern = '(&lt;)|(&gt;)'

for line in sys.stdin:
    if line.strip().startswith('<row'):
        line_list = line.lower().split(' ')
        #достаем часть с тэгами
        try: tags = [str(x.split('=')[1]).replace('\"','') for x in line_list if x.startswith('tags')]
        except: tags = None  
        #достаем часть с creationdate
        try:creationdate = [str(x.split('=')[1]).replace('\"','') for x in line_list if x.startswith('creationdate')]  
        except: creationdate = None
        #если в строке есть тэги и creationdate
        if tags and creationdate:
            #удаляем лишние символы из тэгов
            clean_tags = re.sub(' +',' ',re.sub(pattern, ' ', tags[0])).strip().split(' ')
            #выделяем год из даты
            year = creationdate[0].split('T')[0].split('-')[0]
            for tag in clean_tags:
                print(year, '\t', tag, '\t', 1)