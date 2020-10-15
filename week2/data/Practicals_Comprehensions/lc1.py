birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
#    lists containing the latin names, common names and mean body masses for
#    each species in birds, respectively. 

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         ) 

a = [n for n in species for species in birds]
print(a)
b = [n for species in birds for n in species]
print(b)

latin = [species[0] for species in birds]
common = [species[1] for species in birds]
masses = [species[2] for species in birds]
print(latin)
print(common)
print(masses)

# (2) Now do the same using conventional loops (you can choose to do this 
#     before 1 !).

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         ) 

latin = []
common = []
masses = []
for species in birds:
        latin.append(species[0])
        common.append(species[1])
        masses.append(species[2])