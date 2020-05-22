def CalculatePrimeNumber(self, fromValue, toValue):
    res = []
    for num in range(fromValue,toValue + 1):  
        for i in range(2,num):  
            if (num % i) == 0:  
                break  
        else:  
            res.append(num) 
    return res