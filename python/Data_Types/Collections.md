###Following are the collections###
**Ordered**
Lists,Tuples
**Unordere**
Sets, Dictionaries

## Lists ##
declare/initiailize : x=[8,1,5] or x=[]
obtain size of list : len(x)
add values to list : x.append(4)
sorting lists : x.sort() or sorted(x)
Read value at an index : x[0]
Read all values : for i in x: print i
add values to list via list Comprehension : X=[element for element in x]


## Tuples ##
These are immutable, meaning cannot change (like add/remove values) 
declare/initialize : x=(1,2,3)
accessing : x[0]
unpacking tuples to multiple variables : val1, val2, val3 = (1,2,3) or val1, val2, val3 = x


## Strings ##
Are like Tuples to hold sequence of characters
options available with String
  .split(): split the string (default is space)
  .strip() : remove leading and trailing null spaces
  .upper() : to capitalize all the characters (like alphabets) in string
  .lower() : to deCaptilize all the characters (like alphabets) in string
  .title() : Title capitilizes the first letter in each word.
  .isalpha() : True is the string holds alphabetic alone (any number will fail)
  .isdigit() : True is the string holds only numeric value
  .startswith(<substring>) : True if the actual string starts with the substring specified
  .endswith(<substring>) : True if the actual string ends with the substring specified.
  
  ### Generators and Lambda ###
  Generators are lazy evaluations in a function and they store the result in memory to be used just once. Its using yield keyword instead of return, example
  """
    def cube(seq):
      for n in seq:
        yield n*n*n
  """
  
  Lambda creates anonymous function associated with a variable (for access) without the need to declare any function creating template. Lambda should return something but without specifying return keyword.
  example
  """
    cube=lambda(seq): seq*seq*seq
    cube(4) # results in 64
  """
 
  ## Sets ##
  Sets are collection of elements that are unique but not ordered.
  
  declare/initialize : x = {1,2,3}
  accessing values : for i in x : print (x)
  add values to set : x.add(4)
  union and intersection between sets : x.intersection ({1,5,6)) # This will return 1 
  
 ## Dictionaries ##
  Dictionaries are key value mapping and is the most powerful data type in python. Value can be another dictionary hence dictionary allows nesting (JSON structure)
  declare/initialize : x={"sandeep" : "21212121", "kannan" : "121212121"}
  accessing specific value : x["sandeep"] will provide the 21212121.
  accessing all keys and values : for key in x: print (key,x[key]) # This will print sandeep 21212121 and kannan 121212121 # Default iteration is over the keys.
  accessing all keys : use x.keys() # example for keys in x.keys()
  accessing all values : use x.values() # example for values in x.values()
  
  ## Counters ##
  Counters are specialized dictionary meant for counting of elements.
  declare/initialize : x = counter() # all values are defaulted to zero if not available in the counter and no need to initialize.
  add values : for element in y: x[element]+= 1
  display the entire counter : print(x) # prints the data as Counter({"a":1,"b":3}) (where y = ["a","b","b","b"]
  Helper methods : Most Common elements : x.most_common(1) # This will result in b as b occurs thrice compared to a
  
  
  
  
