from flask import Flask
app = Flask(__name__)
from Controller import MainEntryController as controller
from Proxy import DependentServiceProxy as proxy

@app.route('/')
def index():
    return 'Index Page'

@app.route('/hello')
def hello():
    return controller.SomeFunction()

@app.route('/proxy')
def getProxy():
    return proxy.getProxyDetails()

if __name__ == "__main__":
    app.run(host='127.0.0.1')
