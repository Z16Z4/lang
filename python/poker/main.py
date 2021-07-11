import random
import os
def welcome():
    print("              __                    ")
    print("        _..-''--'----_.             ") 
    print("      ,''.-''| .---/ _`-._          ")                         
    print("    ,' \ \  ;| | ,/ / `-._`-.       ")                          
    print("  ,' ,',\ \( | |// /,-._  / /       ")                         
    print("  ;.`. `,\ \`| |/ / |   )/ /        ")                         
    print(" / /`_`.\_\ \| /_.-.'-''/ /         ")                         
    print("/ /_|_:.`. \ |;'`..')  / /          ")                         
    print("`-._`-._`.`.;`.\  ,'  / /           ")                         
    print("    `-._`.`/    ,'-._/ /            ")                         
    print("      : `-/     \`-.._/             ")                         
    print("      |  :      ;._ (               ")                         
    print("      :  |      \  ` \              ")                         
    print("       \         \   |              ")                         
    print("        :        :   ;              ")
    print("        |           /               ")                         
    print("        ;         ,'                ")                         
    print("       /         /                  ")                         
    print("      /         /                   ")                         
    print("               /                    ")
    print("Welcome!")
    print("Press any Key ..")
    sh = input("")
    os.system("clear")
    river_one = 0
    river_two = 0 
def table():
    card = random.randint(1,13)
    draw = random.randint(1,52)
    if card == 11:
        card =''.join(str(card))
        card = card.replace("11", "Jack")
    elif card == 12:
        card =''.join(str(card))
        card = card.replace("12", "Queen")
    elif card == 13:
        card =''.join(str(card))
        card = card.replace("13", "King")
    elif card == 1:
        card =''.join(str(card))
        card.replace("1", "Ace")
    if draw > 52:
        print("Error")
    elif draw < 13 or draw == 13:
        #print(str(card) + " of Clubs")
        print("  _______  ")
        print("|"+str(card)+"")
        print("|    of   |")
        print("|  Clubs  |")
        print("|         |")
        print("|         |")
        print("|_________|")
    elif draw < 26 or draw == 26:
        #print(str(card)  + " of Diamond")
        print("  _______  ")
        print("|"+ str(card)+"")
        print("|    of   |")
        print("| Diamond |")
        print("|         |")
        print("|         |")
        print("|_________|")
    elif draw < 39 or draw == 39:
        #print(str(card) + " of Hearts")
        print("  _______  ")
        print("|"+ str(card)+"")
        print("|    of   |")
        print("| Hearts  |")
        print("|         |")
        print("|         |")
        print("|_________|")
    elif draw < 52 or draw == 52:
        #print(str(card) + " of Spades")
        print("  _______  ")
        print("|"+ str(card)+"")
        print("|    of   |")
        print("| Spades  |")
        print("|         |")
        print("|         |")
        print("|_________|")
welcome()
print("--------POKER TABLE-----------")
for x in range(3):
    table()
r = input('') 
print("--------RIVER 1-----------")
table()
river_one = 2

r = input('')
print("--------RIVER 2-----------")
table()
river_two = 2
