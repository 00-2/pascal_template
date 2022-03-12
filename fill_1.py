from transliterate import slugify
import json

import pymorphy2
morph = pymorphy2.MorphAnalyzer()
# word = morph.parse('огонь')[0]
# print(word.inflect({'datv'}))

FILENAME = "file_1.json"
with open(FILENAME,"r") as f:
    content = json.loads(f.read())
arr_vars = content['vars']
count_of_var = len(arr_vars)
arr_sort = content['sort']
USERFIO = content['name']

arr_vars = [x.split() for x in arr_vars]
for i in range(len(arr_vars)):
    if arr_vars[i][1] == 's':
        arr_vars[i][1] = 'string'
    if arr_vars[i][1] == 'r':
        arr_vars[i][1] = 'real'
    if arr_vars[i][1] == 'i':
        arr_vars[i][1] = 'integer'
    arr_vars[i] = {'nmvar':arr_vars[i][0],
                   'type':arr_vars[i][1],
                   'example':arr_vars[i][2],
                   'nmvar_eng':slugify(arr_vars[i][0])
                            if slugify(arr_vars[i][0])!=None
                            else arr_vars[i][0]
                    }

print(arr_vars)


with open('template_1_google_disk/unit1.lfm','r') as f_modify_form:
    text_m_f = f_modify_form.read()

text_m_f = text_m_f.replace('SORT1_R', morph.parse(
                                arr_sort[0].replace('sort by ','')
                             )[0]
                            .inflect({'datv'})[0]
                    )\
                    .replace('SORT2_R', morph.parse(
                                arr_sort[1].replace('sort by ','')
                             )[0]
                            .inflect({'datv'})[0]
                    )\
                    .replace('SORT1_',
                        arr_sort[0].replace('sort by ','')
                    )\
                    .replace('SORT2_',
                        arr_sort[1].replace('sort by ','')
                    )\
                    .replace('L1_caption',
                        arr_vars[0]['nmvar_eng']
                    )\
                    .replace('L2_caption',
                        arr_vars[1]['nmvar_eng']
                    )\
                    .replace('L3_caption',
                        arr_vars[2]['nmvar_eng']
                    )\
                    .replace('E1_text',
                        arr_vars[0]['example']
                    )\
                    .replace('E2_text',
                        arr_vars[1]['example']
                    )\
                    .replace('E3_text',
                        arr_vars[2]['example']
                    )

print(text_m_f)