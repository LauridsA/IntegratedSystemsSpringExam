import requests
class DependentServiceProxy:
    ingress_ip = 'http://192.168.99.100'
    service_port = ':80'
    def getPrimeNumbers(self, lower, upper):
        localPath = '/dependentservice/getPrimeNumbers'
        PARAMS = {'from': lower, 'to': upper}
        result = requests.get(self.ingress_ip+self.service_port+localPath, params=PARAMS)
        return result.text