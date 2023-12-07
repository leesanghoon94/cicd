"""
API
"""
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    """
    hello world api
    """
    return 'Hello World!!7'

@app.route("/index")
def index():
    """
    test
    """
    abcdefg = 1
    if abcdefg == 1:
        return "<p>index1</p>"
    return f"<p>index{abcdefg}</p>"
