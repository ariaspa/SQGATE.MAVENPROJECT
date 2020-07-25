x= 15
def funzione_esempio():
    
    print ('funzione esempio')
    y=x
    y+=2
    return (y)

print(funzione_esempio())

def funzione_esempio2():
   
    spam=24
    print ('funzione esempio2(): ' + str(spam))
    return (spam)

print (funzione_esempio2())

def funzione_esempio3():
    spam=24;
    print (spam)
    return spam

somma= 12+funzione_esempio3()
print (somma)
