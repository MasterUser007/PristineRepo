import json
import os
from flask import Flask, render_template_string

app = Flask(__name__)

TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Pavi Dashboard</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f4f4f4; }
        h1 { color: #333; }
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid #888; padding: 8px; text-align: left; }
        th { background-color: #ddd; }
    </style>
</head>
<body>
    <h1>Pavi System Status</h1>
    <table>
        <tr><th>Metric</th><th>Value</th></tr>
        {% for key, value in data.items() %}
        <tr><td>{{ key }}</td><td>{{ value }}</td></tr>
        {% endfor %}
    </table>
</body>
</html>
"""

@app.route("/")
def dashboard():
    data = {}
    if os.path.exists("status.json"):
        with open("status.json") as f:
            data = json.load(f)
    return render_template_string(TEMPLATE, data=data)

if __name__ == "__main__":
    app.run(debug=True, port=5050)
