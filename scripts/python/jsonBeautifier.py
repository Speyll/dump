import json

# Read the JSON file
with open('input.json', 'r') as file:
    json_data = file.read()

# Load JSON data
data = json.loads(json_data)

# Write each JSON object on a single line followed by a newline character
with open('output.json', 'w') as file:
    for i, obj in enumerate(data):
        file.write(json.dumps(obj))
        if i < len(data) - 1:
            file.write(',\n')
        else:
            file.write('\n')
