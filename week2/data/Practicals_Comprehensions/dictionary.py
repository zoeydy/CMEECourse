taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 
tax_dic = dict()
for tax in taxa:
        if tax[1] not in tax_dic.keys():
                tax_dic[tax[1]] = set([tax[0]])
        else:
                tax_dic[tax[1]].add(tax[0])

print(tax_dic)


# set_delete_repeat_name = set(n[1] for n in taxa)
# print(set_delete_repeat_name)

# taxa_change = {a:b for a,b in taxa}
# print(taxa_change)

# def repeat(name):
#         return name.lower().endswith(set_delete_repeat_name)

# a = (n for n in taxa_change if repeat(name))
# print(a)


#z taxa['merge'] = list(set(eval(taxa['Myotis lucifugus']+','+taxa['b']+taxa)))