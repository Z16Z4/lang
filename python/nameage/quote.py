array = [] #array in python 
user = int(input("vaule to go into the range:"))

for n in range(1,100):
    if n % user == 0:
        array.append(n)
print("vaules in the array")
print(array)
print("last number that went into the range")
print(n)
user2 = int(input("so what do you think the range is?"))
if user2 == 100:
    print("Yes, the range is 100")
else:
    print("That number isnt the range of n")
