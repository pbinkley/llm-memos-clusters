import os
import json

def text_to_json(directory_path, output_json_path):
    data = []

    # Iterate through all files in the directory
    for filename in os.listdir(directory_path):
        if filename.endswith(".txt"):
            file_path = os.path.join(directory_path, filename)

            # Read the content of the text file
            with open(file_path, 'r') as file:
                # Read lines until a line starting with "Doc." is found
                for line in file:
                    if line.startswith("Doc."):
                        doc_id = line.strip()
                        break
                else:
                    # If no line starting with "Doc." is found, use the filename as the id
                    doc_id = filename

                # Move the file cursor back to the beginning
                file.seek(0)

                # Read the remaining content of the file
                content = file.read()

            # Create a dictionary for each file
            file_data = {"id": doc_id, "text": content}
            data.append(file_data)

    # Write the data to a JSON file
    with open(output_json_path, 'w') as json_file:
        json.dump(data, json_file, indent=2)

# Example usage
directory_path = './memos'
output_json_path = 'output.json'

text_to_json(directory_path, output_json_path)
