import requests
class DependentServiceProxy:
    ingress_ip = 'http://192.168.99.100'
    service_port = ':80'
    def getPrimeNumbers(self, lower, upper):
        localPath = '/dependentservice/getPrimeNumbers'
        body = {'from': lower, 'to': upper}
        result = requests.post(self.ingress_ip+self.service_port+localPath, data=body)
        return result.text