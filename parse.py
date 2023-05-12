import sys
import json
from bashlex import parser

file_objects = list()

class File:
    def __init__(self, filepath):
        self.name = ''
        self.path = ''
        self.parents = list()

class DefTypes:
    FUNCTION = 1
    ALIAS = 2
    VARIABLE = 3

class Definition:
    def __init__(self, deftype, name, body, file: File):
        self.deftype = deftype
        self.name = name
        self.body = body
        self.file = file

def parse_bash_file(file_path):
    with open(file_path, 'r') as f:
        source_code = f.read()

    data = dict()
    for node in parser.parse(source_code):
        if len(node.parts) == 0:
            continue
    
        if node.kind == 'function':
            name = node.name.word
            body = node.body
            body = source_code[body.pos[0]:body.pos[1]]
            data[name] = Definition(DefTypes.FUNCTION, name, body, )

        if hasattr(node.parts[0], 'word'):
            kind = node.parts[0].word
            if kind == 'alias':
                alias = node.parts[1].word
                name = alias[:alias.find('=')]
                value = alias[alias.find('=') + 1:]
                data[name] = Definition(DefTypes.ALIAS, name, value, )

            if kind == 'export': 
                export = node.parts[1].word
                name = export[:export.find('=')]
                value = export[export.find('=') + 1:]
                data[name] = Definition(DefTypes.EXPORT, name, value, )


main_dir = "/home/mehdi/Studio/Terminal"
for _, _, file in os.walk(main_dir):
    if file.endswith('.rc'):
        data = parse_bash_file(file)

# add fully-featured argument-parser
#  to parse arguments like columns to show,
#  and filtering data based on different things...
