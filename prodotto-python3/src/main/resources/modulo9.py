esci= False
continuare= 'S'
while (esci== False and (continuare=='S' or continuare=='s') ):
    print('''
    Benvenuto al programma calcolatrice
    Creata da Cioffi Domenico

    Elenco funzioni disponibili:
    - Addizione selezione 1;
    - Sottrazione seleziona 2;
    - Moltiplicazione seleziona 3;
    - Sottrazione seleziona 4;
    - Calcolo Esponenziale seleziona 5;
    - per uscire digitare ESC
    ''');

    scelta=input('inserisci il numero selezionato: ')
    print(' scelta inserita è :'+scelta)
    
    if scelta=='1':
        print ('Scelta l\'addizione')
        a= float(input( 'inserisci il primo numero: '))
        b= float(input ('inserisci il secondo numero: '))
        print ('il risultato della somma è :' + str(a+b))
    elif scelta=='2':
        print ('Scelta l\'sottrazione')
        a= float(input( 'inserisci il primo numero: '))
        b= float(input ('inserisci il secondo numero: '))
        print ('il risultato della somma è :' + str(a-b))
    elif scelta=='3':
        print ('Scelta l\'moltiplicazione')
        a= float(input( 'inserisci il primo numero: '))
        b= float(input ('inserisci il secondo numero: '))
        print ('il risultato della somma è :' + str(a*b))
    elif scelta=='4':
        print ('Scelta l\'divisione')
        a= float(input( 'inserisci il primo numero: '))
        b= float(input ('inserisci il secondo numero: '))
        print ('il risultato della somma è :' + str(a/b))
    elif scelta=='5':
        print ('Scelta l\'addizione')
        a= float(input( 'inserisci la base: '))
        b= float(input ('inserisci l\'esponente: '))
        print ('il risultato della somma è :' + str(a**b))
    elif scelta=="ESC":
        break
    
    continuare=input('\n vuoi continuare? S/N ')

