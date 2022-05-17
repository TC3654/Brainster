# PART 1 (7 points)
#
# Lets design Zoo, in part 1 you should create Zoo and Animal class.
# Internally, the 'Zoo' should use another class, a 'Animal' class.
#
#
# Animal class should have Name, AnimalType, Species, Mass and needed space for the animal Space
#       (integer, presenting square meters)
# Zoo class constructor should have Name, Location and list of objects, from class Animal
# Location should be property and it can't be changed.
#
# Your requirements are:
#
#         - The Zoo and Animal class should have overrided method __str__. It should print first info
#                 related to the Zoo and then info about every Animal that's in the Zoo.
#         - Zoo should have methods for changing list of animals, Add and Remove.
#         - Also, you should have methods in Zoo for
#               - calculating minimum needed space for the animals
#               - total mass for all of the animals
#               - average mass
#               - average needed space
#               - method that will return dictionary and count animal types
#                       (Example: {
#                               "Mammal": 3,
#                               "Bird": 8,
#                               "Reptile": 5
#                            })
#
#
#  - Example animal:
#       Name: Bob
#       AnimalType: Mammal
#       Species: Bear
#       Mass: 300
#
#  - Example zoo:
#       Name: Henry Doorly Zoo
#       Location: Omaha, Nebraska
#       Animals: [ ... List of animal objects ... ]


class Animal:
    
    def __init__(self, name, aType, species, mass, space):
        self.name = name
        self.aType = aType
        self.species = species
        self.mass = mass
        self.space = space
        
    def __str__(self):
        return "Name: {}\nAnimal Type: {}\nSpecies: {}\nMass: {}\nSpace needed: {}\n".format(self.name, self.aType, self.species, self.mass, self.space)

    
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
            if i.aType in atypes:
                atypes[i.aType] += 1
            else:
                atypes[i.aType] = 1
                
        return atypes


    
bob = Animal("Bob", "Mammal", "Bear", 300, 1000)

frosty = Animal("Frosty", "Bird", "Penguin", 18, 40)

pongo = Animal("Pongo", "Bird", "Penguin", 20, 40)

jumpy = Animal("Jumpy", "Mammal", "Kangaroo", 90, 300)

LJ = Zoo("Zoo Ljubljana", "Ljubljana, Slovenia")
#ZG = Zoo("Zagreb Zoo", "Zagreb, Croatia")

LJ.add(bob)
LJ.add(pongo)
LJ.add(jumpy)
LJ.add(frosty)

print(LJ)

#LJ.remove(bob)
#print(LJ)

LJ.min_space()
LJ.total_mass()
LJ.average_mass()
LJ.average_space()
LJ.type_count()

LJ.location = "Zagreb"
