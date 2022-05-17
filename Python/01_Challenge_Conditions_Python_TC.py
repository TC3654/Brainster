'''
CHALLENGE:
    Create the football 'rock scissors paper' game. Your program should start by asking the player's team - which
        needs to be Brazil, Croatia, Poland or Spain - attribute a random team to the computer, and declare the
        winner according to the following rules:
        - Brazil beats Croatia
        - Croatia beats Poland
        - Poland beats Brazil
        - Spain always lose (eheheh)
        - if both players select the same team (except Spain), it's a tie
    To create the computer's move, you can use the random.choice() function. To learn how to use this function,
        please read: https://www.w3schools.com/python/ref_random_choice.asp

    If you don't know the original 'rock scissors paper' game, watch this video: https://youtu.be/2dsHuU10udY

EXAMPLE (1):
    (output) >> Enter your team: [Brazil/Croatia/Poland/Spain]
    (input) >> Portugal
    (output) >> Invalid team! Bye :)

EXAMPLE (2):
    (output) >> Enter your team: [Brazil/Croatia/Poland/Spain]
    (input) >> Brazil
    (output) >> Brazil beats Croatia! You win!

EXAMPLE (3):
    (output) >> Enter your team: [Brazil/Croatia/Poland/Spain]
    (input) >> Poland
    (output) >> Croatia beats Poland! You lose!

EXAMPLE (4):
    (output) >> Enter your team: [Brazil/Croatia/Poland/Spain]
    (input) >> Spain
    (output) >> Spain? Ahahahah! You lose!

EXAMPLE (5):
    (output) >> Enter your team: [Brazil/Croatia/Poland/Spain]
    (input) >> Croatia
    (output) >> Both players selected Croatia. It's a tie!
'''

import random  # Don't delete this line! You'll need it to use the random.choice() function

userSel = input("Enter your team: [Brazil/Croatia/Poland/Spain]")

teams = ["Brazil", "Croatia", "Poland", "Spain"]

if userSel not in teams:
    print("Invalid team! Bye :)")
elif userSel == teams[3]:
    print("Spain? Ahahahah! You lose!")
else:
    del teams[3]
    #print(teams)
    compSel = random.choice(teams)
    #print(compSel)
    if userSel == teams[0] and compSel == teams[1]:
        print("Brazil beats Croatia! You win!")
    elif userSel == teams[1] and compSel == teams[2]:
        print("Croatia beats Poland! You win!")
    elif userSel == teams[2] and compSel == teams[0]:
        print("Poland beats Brazil! You win!")
    elif userSel == compSel:
        print(f"Both players selected {userSel}. It's a tie!")
    else:
        print(f"{compSel} beats {userSel}! You lose!")