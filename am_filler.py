import json
import sys
import os
import re

# SERVER = "http://localhost:4444/wd/hub"

def main():
    # side_file = sys.argv[1]
    # data_file = sys.argv[2]

    # application = re.match(r"([\w\s]*)\.side", side_file)[1]
    # applicant = re.match(r"\.\/tmp\/([\d]+)\.json", data_file)[1]

    test_side_file = "./side.generated/test.side"
    test_data_file = "./data/a1.json"

    data = json.load(open(test_data_file))
    derive(data)
    print(data)
    unfilled = json.load(open(test_side_file))
    filled = fill(unfilled, data)

    test_file = "outputs/a1.side"
    json.dump(filled, open(test_file, "w+"))
    


def derive(native):
    derived = dict()

    derived['fullName'] = native['firstName'] + " " + native['lastName']
    
    native.update(derived)


def fill(unfilled, data):
    # old_commands = unfilled['tests'][0]['commands']
    # print(len(old_commands))
    old_commands = unfilled['tests'][0]['commands']
    new_commands = []
    for command in old_commands:
        if command['command'] == 'type':
            label = command['value']
            command['value'] = data[label]


        new_commands.append(command)

    filled = unfilled.copy()
    filled['tests'][0]['commands'] = new_commands
    return filled

if __name__ == '__main__':
   main()

'''
Below is an outline of the structure of
the .side file, which is a pseudo-json.

id
version
name
url
tests [
    id
    name
    commands [
    /   id
    c   comment
    o   command
    m   target
    m   targets [
    a       [ lists of ]
    n       [ locators ]
    d   ]
    \   value
]
suites [
/   id
|   name
|   persistSession
|   parallel
|   timeout
\   tests []
]
urls []
plugins []
'''

