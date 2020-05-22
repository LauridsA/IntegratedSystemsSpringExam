from flask import Flask, request
app = Flask(__name__)
from Controller import MainDependentController as controller

@app.route("/dependentservice/getPrimeNumbers",  methods=['POST'])
def hello():
    fromparam = request.form['from']
    toparam = request.form['to']
    res = controller.CalculatePrimeNumber(fromparam, toparam)
    return res

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
