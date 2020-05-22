from flask import Flask
app = Flask(__name__)

@app.route("/dependentservice")
def hello():
    print('testing2')
    return "Hello from Python!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
