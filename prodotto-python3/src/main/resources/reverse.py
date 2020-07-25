def reverse (stringa):
    lunghezza= len(stringa)-1
    print ('la lunghezza della parola è :' +str(lunghezza))
    nuovaStringa='';
    indice=lunghezza
    while indice>=0 :
        nuovaStringa+=stringa[indice]
        indice-=1
    print('stringa invertita è : '+nuovaStringa)

primaStringa='abcdefghilmno'
reverse(primaStringa)

print(list(primaStringa))
