from flask import Flask, request
app = Flask(__name__)

@app.route("/dependentservice/getPrimeNumbers",  methods=['POST'])
def hello():
    return request.form['to']

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
