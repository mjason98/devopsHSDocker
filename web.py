from flask import Flask, jsonify, request

app = Flask(__name__)

class SimpleResult:
    name:str = ""
    description:str = ""
    url:str = ""
    
    def __init__(self, name, desc, url) -> None:
        self.name:str=name
        self.description:str=desc
        self.url:str=url

def SimpleFactory(url:str):
    simple = SimpleResult("Hello", "Mariano Jason", url)
    return simple

@app.route('/api')
def hello():
    simple = SimpleFactory(request.url)
    return jsonify(simple)

    # return jsonify(
    #     name="Hello",
    #     description="Mariano Jason",
    #     Url=request.url
    # )

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=4444)
