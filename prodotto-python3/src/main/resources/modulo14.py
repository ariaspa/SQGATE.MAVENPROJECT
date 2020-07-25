def divisione (a,b):
    try:
        risultato = a/b
        print ('risultato: ' +str(risultato))
    except ZeroDivisionError:
        print (' Si è verificato un errore di divisione ')
