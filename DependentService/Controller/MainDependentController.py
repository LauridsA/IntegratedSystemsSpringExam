def CalculatePrimeNumber(fromValue, toValue):
    res = []
    for num in range(fromValue,toValue + 1):  
        for i in range(2,num):  
            if (num % i) == 0:  
                break  
        else:  
            res.append(str(num)) 
    return res