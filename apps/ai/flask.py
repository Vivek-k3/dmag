import os
import flask


app = flask.Flask(__name__)

@app.route('/health')
def health():
    return "Your Healthy API"


@app.route('/api/v1/chat', methods=['POST'])
def chat():
    message = flask.request.json['message']
    model=flask.request.json['model']
    api_key=flask.request.json['api_key']
    