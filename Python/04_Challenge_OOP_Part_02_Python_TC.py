# PART 2 (8 points)
#
# You should change the Animal class and do inheritance. It will be needed to be removed AnimalType in Animal class
# and instead of that you should have 3 derived classes out of Animal class, called: Mammal, Reptile and Bird
#
#   Mammals:
#     - LitterSize - The average number of offspring the mammal has. A whole number ≥ 1
#
#   Reptiles:
#     - Indicates whether the reptile has a venomous bite. One of: Venomous, Nonvenomous
#
#   Birds:
#     - Wingspan: The wingspan of the bird in inches. A whole number ≥ 1
#     - TalksOrMute: Indicates whether the bird talks. One of: Talks, Mute
#     - Phrase: What the bird says. May contain whitespace, but is no more than one line long.
#
#   Requirements:
#       - Override the method __str__ for all of the classes.
#       - Add method Action in Animal class and override it in the derived classes
#           (EXAMPLE Action should print string that it's common for that type of animal.)

class Animal:
    
    def __init__(self, name, species, mass, space):
        self.name = name
        self.species = species
        self.mass = mass
        self.space = space
        
    def __str__(self):
        return "Name: {}\nSpecies: {}\nMass: {}\nSpace needed: {}\n".format(self.name, self.species, self.mass, self.space)
    
    def action(self):
        return "We are adorable"
    
    
class Mammal(Animal):
    
    def __init__(self, name, species, mass, space, litterSize):
        super().__init__(name, species, mass, space)
        self.litterSize = litterSize
        
    def __str__(self):
        return "Name: {}\nType: {}\nSpecies: {}\nMass: {}\nSpace needed: {}\nAverage litter size: {}\n".format(self.name, self.__class__.__name__, self.species, self.mass, self.space, self.litterSize)
    
    def action(self):
        return "Our babies drink milk from their mamas."

        
class Reptile(Animal):
    
    def __init__(self, name, species, mass, space, venom):
        super().__init__(name, species, mass, space)
        self.venom = venom
        
    def __str__(self):
        return "Name: {}\nType: {}\nSpecies: {}\nMass: {}\nSpace needed: {}\nIs venomous: {}\n".format(self.name, self.__class__.__name__, self.species, self.mass, self.space, self.venom)
    
    def action(self):
        return "We are cold-blooded and we have scales."
    
    
class Bird(Animal):
    
    def __init__(self, name, species, mass, space, wingspan, talks, phrase):
        super().__init__(name, species, mass, space)
        self.wingspan = wingspan
        self.talks = talks
        self.phrase = phrase
    
    def __str__(self):
        return "Name: {}\nType: {}\nSpecies: {}\nMass: {}\nSpace needed: {}\nWingspan: {}\nDoes talk: {}\nIt says: {}\n".format(self.name, self.__class__.__name__, self.species, self.mass, self.space, self.wingspan, self.talks, self.phrase)

    def action(self):
        return "We have wings, eventhough not all of us fly."
    
    
class Zoo:
    
    def __init__(self, name, location):
        self.name = name
        self.__location = location
        self.animals = []
        
    def add(self, animal):
        self.animals.append(animal)
        
    def remove(self, animal):
        self.animals.remove(animal)
        
    def get_location(self):
        return self.__location
    
    def set_location(self, new):
        print("Nope! Access denied!")
    
    location = property(get_location, set_location)
        
    def __str__(self):
        print("Name: {}\nLocation: {}\n\nAnimals in the zoo:\n".format(self.name, self.__location))
        
        for i in self.animals:
            print(i)
            
        return "\n"
     
        
    #calculating minimum needed space for the animals    
    def min_space(self):
        
        min_space = 0
        
        for i in range(len(self.animals)):
            min_space += self.animals[i].space
            
        return min_space
    
    
    #total mass for all of the animals
    def total_mass(self):
        total = 0
        
        for i in self.animals:
            total += i.mass
            
        return total
    
    
    #average mass
    def average_mass(self):
        return self.total_mass()/len(self.animals)
    
    
    #average needed space
    def average_space(self):
        return self.min_space()/len(self.animals)
    
    
    #method that will return dictionary and count animal types
    def type_count(self):
        atypes = {}
        
        for i in self.animals:
            if i.__class__.__name__ in atypes:
                atypes[i.__class__.__name__] += 1
            else:
                atypes[i.__class__.__name__] = 1
                
        return atypes
    
    

bob = Mammal("Bob", "Bear", 300, 1000, 3)

frosty = Bird("Frosty", "Parrot", 2, 60, 0.7, True, "Gimme food")

pongo = Bird("Pongo", "Penguin", 20, 40, 0.8, False, "Squak")

jumpy = Mammal("Jumpy", "Kangaroo", 90, 300, 2)

misterio = Reptile("Misterio", "Chameleon", 0.1, 1, False)

iggy = Reptile("Iggy", "Iguana", 2.5, 10, True)

print(bob)
print(bob.action())
#print(iggy.action())
#print(pongo.action())
#print(misterio)
#print(frosty)

ZG = Zoo("Zagreb Zoo", "Zagreb, Croatia")

ZG.add(bob)
ZG.add(pongo)
ZG.add(jumpy)
ZG.add(frosty)
ZG.add(misterio)
ZG.add(iggy)

print(ZG)

#ZG.remove(bob)
#print(ZG)

print(ZG.min_space())
print(ZG.total_mass())
print(ZG.average_mass())
print(ZG.average_space())
print(ZG.type_count())