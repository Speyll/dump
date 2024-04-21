from bs4 import BeautifulSoup
import json

def html_to_json(html_file, output_file=None):
    """
    Reads HTML content from a file, extracts link data, and converts it to JSON.

    Args:
        html_file (str): Path to the HTML file.
        output_file (str, optional): Path to the output JSON file. Defaults to None (printing to console).

    Returns:
        str: The JSON-formatted string representing the extracted link data.
    """

    with open(html_file, 'r') as f:
        html_content = f.read()

    soup = BeautifulSoup(html_content, 'html.parser')

    # Extract link data based on your HTML structure
    links = []
    for link in soup.find_all('a'):  # Replace with appropriate selector
        name = link.text.strip()
        url = link['href']
        tags = []  # Extract tags if applicable
        links.append({'name': name, 'url': url, 'tags': tags})

    # Convert links to JSON
    json_data = json.dumps(links, indent=4)

    if output_file:
        with open(output_file, 'w') as f:
            f.write(json_data)
    else:
        print(json_data)

    return json_data

# Example usage:
html_file = "test.html"  # Replace with your file path
output_file = "output.json"  # Optional: Path to output JSON file

json_output = html_to_json(html_file, output_file)
