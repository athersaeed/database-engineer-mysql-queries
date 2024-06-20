import random as rnd
with open("options.txt", "r") as file:
    data = file.read()
    data1 = data.split("\n")
print(rnd.choice(data1))

