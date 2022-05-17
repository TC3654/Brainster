'''
CHALLENGE:
    Create a game in which the user has to guess a secret country. You guess by picking letters. If you pick a letter
        that is in the country's name, that letter is revealed from a set of blank letters that match the country's
        name; however, if you pick a letter that is not in the country's name, you waste an attempt. When you don't
        have more attempts, you lose the game.

REQUIREMENTS
    The secret word should be randomly selected from a list of countries, as in Challenge 1. This list is already
        provided and you can change if you don't like the countries in the list. For example, I removed Spain :)
    The user chooses the difficulty level. Different difficulty levels have different numbers of attempts:
        Hard level --> number of attempts = length of the country's name + 1
        Medium level -->  number of attempts = length of the country's name * 2
        Easy level -->  number of attempts = length of the country's name * 3
    The user wins if he/she guesses all the characters while the number of attempts is greater than 0
    When the user wins it should print a celebration message
    The user loses the number of attempts is equal to 0 and he/she still has characters to guess
    When the user loses it should print a message saying that the user lost and identifying the correct answer
    The first character of each country's name is capitalized, but the comparison should assume that the user always
        inserts lowercase letters

COSMETIC DETAILS
    \n --> allows you to insert a line to separate the sentences
        Try the following code to see how it works:
            for i in range(5):
                print('\n Do you see that it inserts a blank line?')

    end='' --> allows you to print everything on the same line
        Try the following code to see how it works:
            for i in range(5):
                print('Everything in the same line...', end='')

EXAMPLE (1):
    (output) >> Choose the difficulty level: [H/M/E]
    (input) >> H
    (output) >> You'll have 10 attempts
    (output) >>
    (output) >> Starting now! Good luck :)
    (output) >>
    (output) >> Insert character:
    (input) >> a
    (output) >> A_______a
    (output) >> You have 9 attempts
    (output) >>
    (output) >> Insert character:
    (input) >> e
    (output) >> A__e____a
    (output) >> You have 8 attempts
    (output) >>
    (output) >> Insert character:
    (input) >> i
    (output) >> A__e__i_a
    (output) >> You have 7 attempts
    (...)
    (output) >> Insert character:
    (input) >> n
    (output) >> Argen_ina
    (output) >> You have 2 attempts
    (output) >>
    (output) >> Insert character:
    (input) >> t
    (output) >> Argentina
    (output) >> You won!

EXAMPLE (2):
    (output) >> Choose the difficulty level: [H/M/E]
    (input) >> E
    (output) >> You'll have 18 attempts
    (output) >>
    (output) >> Starting now! Good luck :)
    (output) >>
    (output) >> Insert character:
    (input) >> a
    (output) >> ____a_
    (output) >> You have 17 attempts
    (output) >>
    (output) >> Insert character:
    (input) >> z
    (output) >> ____a_
    (output) >> You have 16 attempts
    (...)
    (output) >> Insert character:
    (input) >> x
    (output) >> ____ay
    (output) >> You have 1 attempts
    (output) >>
    (output) >> Insert character:
    (input) >> p
    (output) >> ____ay
    (output) >> You lost! The country was Norway
'''
import random  # Do not delete this line!

countries = ["Afghanistan","Albania","Algeria","Andorra","Angola","Argentina","Armenia","Australia","Austria",
                "Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan",
                "Bolivia","Botswana","Brazil","Brunei" "Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia",
                "Cameroon","Canada","Chad","Chile","China","Colombia","Comoros","Congo","Croatia","Cuba","Cyprus",
                "Denmark","Djibouti","Dominica","Ecuador","Egypt","Eritrea","Estonia","Eswatini","Ethiopia","Fiji",
                "Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea",
                "Guyana","Haiti","Honduras","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel",
                "Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Korea","Kuwait","Kyrgyzstan",
                "Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Madagascar",
                "Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco",
                "Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands",
                "Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Panama","Paraguay","Peru","Philippines",
                "Poland","Portugal","Qatar","Romania","Russia","Rwanda","Samoa","Senegal","Serbia","Seychelles",
                "Singapore","Slovakia","Slovenia","Somalia","Sudan","Suriname","Sweden","Switzerland",
                "Tajikistan","Thailand","Togo","Tonga","Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine",
                "Uruguay","Uzbekistan","Vanuatu","Venezuela","Yemen","Zambia","Zimbabwe"]

s = random.choice(countries)
secret = list(s)
attempts = 0
guessed = []
char = ""

#print(secret)

# First let's get the number of attempts
dif = input("Choose the difficulty level: [H/M/E]")

while dif not in ('H', 'M', 'E'):
    dif = input("Not a valid choice. Choose the difficulty level: [H/M/E]")

if dif == 'H':
    attempts = len(secret) + 1
elif dif == 'M':
    attempts = len(secret) * 2
else:
    attempts = len(secret) * 3
    
print(f"You'll have {attempts} attempts. \nStarting now! Good luck :)")

# creating list for the user's guesses
for i in range(len(secret)):
    guessed += "_"
    #print(guessed[i], end='')
    
#print("This:", guessed)

# while loop for guessing
while attempts > 0:
    char = input("Insert character:")
    
    # checking if the user-chosen char matches any chars in secret word
    for i in range(len(secret)):
        if char == secret[i].lower():
            if i == 0:
                guessed[i] = char.upper()
            else:
                guessed[i] = char
        print(guessed[i], end=' ')
    
    # checking if the user already guessed correctly
    if guessed == secret:
        print("\nYou win!")
        break
    
    attempts -= 1
    
    #different responses for number of attempts left
    if attempts == 1:
        print(f"\nYou have only {attempts} attempt left.")
    elif attempts == 0:
        print(f"\nYou lose! The secret word was: {s}")
    else:
        print(f"\nYou have {attempts} attempts left.")