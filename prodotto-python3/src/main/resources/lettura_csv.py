import csv

with open ("./esempio.csv", newline="",encoding="ISO-8859-1") as filecsv:
    lettore= csv.reader(filecsv,delimiter=",")
    #header= next(lettore)
    #print (header)
    dati=[ (riga[0],riga[2], riga[3]) for riga in lettore if riga[1] == 'lombardia']
    print (dati)

