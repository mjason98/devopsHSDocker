from flask import Flask, jsonify, request

app = Flask(__name__)

def SimpleFactory(url:str):
    simple = {"name":"Hello", "description":"Mariano Jason", "url":url}
    return simple

@app.route('/api')
def hello():
    simple = SimpleFactory(request.url)
    return jsonify(simple)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=4445)
