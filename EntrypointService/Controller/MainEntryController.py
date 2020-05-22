import sys
sys.path.append('../Proxy')
from Proxy import DependentServiceProxy as proxyModule

def GetPrimeNumber():
    # logging request
    print('LOG: request information') 
    #create proxy
    prox = proxyModule.DependentServiceProxy()
    #perform request, get result
    lower = 1
    upper = 50
    response = prox.getPrimeNumbers(lower, upper)
    # logging simulation
    print('LOG: result from dependent service')
    print(response) 
    return response