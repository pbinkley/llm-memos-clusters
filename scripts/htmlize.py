import sys
import os
import re
import json
from jinja2 import Template
import pdb

def generate_html(json_path, output_html_path, model_name):
    with open(json_path, 'r') as json_file:
        json_data = json.load(json_file)

    # Enumerate entries in Python and pass to the template
    enumerated_entries = list(enumerate(json_data, start=1))

    template_str = '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Clusters of Memos for {{ model_name }}</title>
    </head>
    <style>
    .summary { 
        margin-left: 2em; 
        font-style: italic; 
        border: 1px solid black; 
        background: #ddd; 
        padding: 10px; 
    }
    .item { 
        margin-left: 2em; 
        border: 1px solid black; 
        padding: 10px; 
    }
    </style>
    <body>
    <h1>Model: {{ model_name}}</h1>
    <h2>Clusters</h2>
    <ul>
        {% for idx, entry in enumerated_entries %}
            <li><a href="#cluster_{{ idx }}">Cluster {{ idx }}</a> ({{ entry['items'] | length }} memo{% if entry['items'] | length > 1 %}s{% endif %}): 
            {{ entry['summary'] }}</li>
        {% endfor %}
    </ul>
        {% for idx, entry in enumerated_entries %}
            <h2 id="cluster_{{ idx }}">Cluster {{ idx }}</h2>
        
            <h3>Summary</h3>   
            <div class="summary">{{ entry['summary'] }}</div>
            
            {% for item in entry['items'] %}
                <h3>{{ item['id'] }}</h3>
                <div class="item">
                    {% for paragraph in item['content'].split('\n\n') %}
                        <p>{{ paragraph }}</p>
                    {% endfor %}
                </div>
            {% endfor %}
        {% endfor %}
    </body>
    </html>
    '''

    template = Template(template_str)
    rendered_html = template.render(enumerated_entries=enumerated_entries, model_name=model_name)

    # pdb.set_trace()

    with open(output_html_path, 'w') as html_file:
        html_file.write(rendered_html)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py input.json")
        sys.exit(1)

    input_json_path = sys.argv[1]
    file_name = os.path.splitext(input_json_path)[0]
    model_name = re.sub(r"^cluster-output-(.*)-\d*$", r'\1', file_name)
    output_html_path = f"{file_name}.html"

    generate_html(input_json_path, output_html_path, model_name)
