birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# Hints: use the "print" command! You can use list comprehensions!

# latin = print(*{n[0] for n in birds}, sep="\n")
# common =print(*{n[1] for n in birds}, sep="\n")
# mass = print(*{n[2] for n in birds}, sep="\n")

for i in birds:
    print('latin:', i[0])
    print('common:', i[1])
    print('mass:', i[2])