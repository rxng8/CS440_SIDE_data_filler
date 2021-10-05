import json
import sys
import os
import re

# SERVER = "http://localhost:4444/wd/hub"
debugging = True

def main():
    
    if not os.path.exists("outputs"):
        os.mkdir("outputs")

    side_file = sys.argv[1]
    data_folder = sys.argv[2]

    # application = re.match(r"([\w\s]*)\.side", side_file)[1]
    # applicant = re.match(r"\.\/tmp\/([\d]+)\.json", data_file)[1]

    for data_file in os.listdir(data_folder):
        if not data_file.endswith(".json"):
            continue

        data_path = os.path.join(data_folder, data_file)

        data = json.load(open(data_path))
        derive(data)
        unfilled = json.load(open(side_file))
        filled = fill(unfilled, data)

        result_file_path = f"outputs/{data_file[:-4]}side"
        json.dump(filled, open(result_file_path, "w+"))
        print(f"Successfully filled the script with applicant data in {data_file}")
    

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
        # if command['command'] == 'if':
        #     if_mode = True
        # elif command['command'] == 'end':
        #     if_mode = False

        # Check and append the data
        if command['command'] == 'type':
            label = command['value']
            command['value'] = data[label]
            new_commands.append(command)
        elif command['command'] == 'if':
            tag_label = command['target'] # get the tag value
            bool_label = data[tag_label] # Get the actual binary data in the user json file
            # put the binary data in
            if bool_label: 
                command['target'] = "true"
            else:
                command['target'] = "false"
            command['value'] = "true"
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

