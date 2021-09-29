import json
import sys
import os
import re

# SERVER = "http://localhost:4444/wd/hub"
debugging = True

def main():
    
    side_file = sys.argv[1]
    data_file = sys.argv[2]

    test_side_file = "./side.generated/a1.side"
    test_data_file = "./data/a1.json"
    # application = re.match(r"([\w\s]*)\.side", side_file)[1]
    # applicant = re.match(r"\.\/tmp\/([\d]+)\.json", data_file)[1]

    data = json.load(open(data_file))
    derive(data)
    print(data)
    unfilled = json.load(open(side_file))
    filled = fill(unfilled, data)

    test_file = "outputs/a1.side"
    json.dump(filled, open(test_file, "w+"))
    


def derive(native):
    derived = dict()

    derived['fullName'] = native['firstName'] + " " + native['lastName']
    
    native.update(derived)


def fill(unfilled, data):
    old_commands = unfilled['tests'][0]['commands']
    new_commands = []

    if_mode = False

    for command in old_commands:
        
        # Check if else mode. One-level (no nested if-else, if nested, need to implement stack)
        if command['command'] == 'if':
            if_mode = True
        elif command['command'] == 'end':
            if_mode = False

        # Check and append the data
        if command['command'] == 'type':
            label = command['value']
            command['value'] = data[label]
            new_commands.append(command)
        elif if_mode:
            tag_label = command['target'] # get the tag value
            bool_label = data[tag_label] # Get the actual binary data in the user json file
            # put the binary data in
            # if bool_label: 
            #     command['target'] = "true" # Need to check primitive binary value of side script
            # else:
            #     command['target'] = "false" # Need to check primitive binary value of side script
            command['target'] = bool_label
            new_commands.append(command)
        else:
            new_commands.append(command)

        # If debugging then pause between actions
        if debugging:
            new_commands.append({
                "id": "fbf35ed7-1a28-4540-a93d-3cb8ba0e012a",
                "comment": "",
                "command": "pause",
                "target": "1000",
                "targets": [],
                "value": ""
            })

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

