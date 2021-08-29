#Lists 

#creating a list
mylist = []


#can store data types in lists
mylist2 = ["apple", "cherry", "orange"]

#can contain all datatypes and dulplicate items
mylist3 = [5, True, "apple", "apple"]

item = mylist3[0]
print(item)
#should print 5 from after indexing the list
item = mylist3[-1]
print(item)
#should print the last item in the list 'apple'

#print all items in a list
for i in mylist3:
    print(i)

#check if item is in a list
if "apple" in mylist3:
    print("yes")
else:
    print("no")

#check how many items in a list
print(len(mylist3))

#add items to a list
mylist3.append("lemon")

#insert item at specific position based on the idex of the list
mylist3.insert(1, "blueberry")

#printing all the items
for i in mylist3:
    print(i)

#returns last item and removes it from list
item = mylist3.pop()
print(item)
print(mylist3)

#remove specific element 
item = mylist3.remove("apple")
#vaule error will occur if its not in a list

#remove all items from the list
item = mylist3.clear()

mylist3.append("i should be the only item in the list")
print(mylist3)

mylist3.append(2)
mylist3.append(True)
print(mylist3)

#you can sort lists
newlist = [4, 3, 2, 1, -1, 5, 8]

item = newlist.sort()

#or you can sort this way 

new_list = sorted(newlist)
print(newlist)
#printing new sorted list
print(new_list)

list4 = [1, 2, 3, 4, 5]
#add lists together
new_list = mylist3 + list4
print(new_list)

#slicing, access parts of your list 
list_slice = [1,2,3,4,5,6,7,8,9]

#start index 1 and stop index 5
a = [list_slice[1:5]]
print(a)

#if we dont specify a start index it starts from the beginning
b = [list_slice[:5]]
print(b)

#if you dont specify a stop index it will list until the end
c = [list_slice[1:]]
print(c)

#optional step index 
#from the beginning to end with step 1
d = [list_slice[1::1]]
print(d)
#negative index, can reverse list
e = [list_slice[::-1]]
print(e)

list_org = ["banana", "cherry", "apple"]

list_cpy = list_org

list_cpy.append("lemon")

print(list_cpy)

print(list_org)
#original list has a lemon in it, because they share
#the same memory 

#can copy a list by using 
list_cpy = list_org.copy()
#can also make a copy using 
list_cpy = list(list_org)
#or you can use slicing
list_cpy = list_org[:]
#or can use
myNewlist = [1,2,3,4,5,6]
#expression the for loop over list 
b = [i*i for i in myNewlist]
print(b)


