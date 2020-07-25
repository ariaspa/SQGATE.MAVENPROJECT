def moltiplicatore ():
    try:    
        a= int( input ('inserisci il primo valore: '))
        b= int( input ('inserisci il secondo valore: '))


        risultato= a * b
        print (' il risultato è : '+ str(risultato))
               
    except ValueError:
        print ('solo caratteri numerici')
    finally:
        print(' grazie di aver usato questo programma. Alla prossima')
    
