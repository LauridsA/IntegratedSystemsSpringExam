from flask import Flask
app = Flask(__name__)
from Controller import MainEntryController as controller

@app.route('/')
def index():
    return 'Health Check'

@app.route('/hello')
def getPrimeNumber():
    return controller.GetPrimeNumber()

if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080) #dont forget to flip IP to 0.0.0.0
