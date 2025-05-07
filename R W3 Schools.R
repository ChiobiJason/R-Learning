# Printing
"Hello World"

print("Hello World")

5
10
15

# Loops
for (x in 1:10) {
  print(x * 2)
}

# This is
# a multiline
# comment

# String Concatenation
name <- "Chisom"
surname <- "Chiobi"
age <- 19

paste("My name is", name)
paste(name, surname)
paste(name, age)
name + age # Error

# Multiple Variables
middleName <- otherName <- secondName <- "Jason"

# All are set to "Jason"
middleName 
otherName
secondName

# Legal variable names:
myvar <- "John"
my_var <- "John"
myVar <- "John"
MYVAR <- "John"
myvar2 <- "John"
.myvar <- "John"

# Illegal variable names:
2myvar <- "John"
my-var <- "John"
my var <- "John"
_my_var <- "John"
my_v@ar <- "John"
TRUE <- "John"

# Data Types
# Numeric
x <- 10.5
class(x)

# Integer
x <-1000L # "L" declares this as an integer
class(x)

# Complex
x <- 9i + 3
class(x)

# Character/String
x <- "My name is Jason"
class(x)

# Logical/Boolean
x <- FALSE
class(x)

# Type Conversion
x <- 1L # integer
y <- 2 # numeric

# Integer to Numeric
a <- as.numeric(x)
class(a)

# Numeric to Integer
b <- as.integer(y)
class(b)

# Integer to Complex
c <- as.complex(x)
class(c)

# Built-in Math Functions
max(100, 1, -3)
min(-10000, 10000, 7)
abs(-3)
sqrt(16)
ceiling(1.4) # rounds number upwards to nearest integer
floor(1.4) # rounds number downwards to nearest integer

# Strings
str <- "Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."

str
cat(str) # make line breaks to be inserted at the same position as in the code
nchar(name) # length of string

str <- "Hello World!"

# to check if a character or a sequence of characters are present in a string
grepl("H", str) 
grepl("Hello", str)
grepl("X", str)

str <- "I love \"R\" programming"
str
cat(str)

# Booleans
100 == 190
5 > 2
2 < 5

a <- 3
b <- 9

if (b > a) {
  print(paste(b, "is bigger"))
} else {
  print(paste(a, "is bigger"))
}

# Operators
2 + 2
3 - 1
2 * 2
4 / 2
2 ^ 2
5 %% 2 # modulo (remainder from division)
15 %/% 2 # integer division (rounds the result down to the nearest whole number)

my_var <- 3

my_var <<- 3 # global variable assignment

3 -> my_var

3 ->> my_var # global variable assignment

my_var

# Logical Operators
c(TRUE, FALSE, TRUE) & c(TRUE, TRUE, FALSE) # Result: TRUE FALSE FALSE

c(TRUE, FALSE) && c(TRUE, TRUE) # Result: TRUE (only compares the first 
                                # TRUE && TRUE)

c(TRUE, FALSE, FALSE) | c(FALSE, TRUE, FALSE) # Result: TRUE TRUE FALSE

c(TRUE, FALSE) || c(FALSE, TRUE) # Result: TRUE (only compares first: 
                                 # TRUE || FALSE)

!TRUE   # FALSE
!FALSE  # TRUE

# IF-ELSE STATEMENTS
a <- 10
b <- 10

if (b > a) {
  print("b is greater than a")
} else if (b == a) {
  print("b and a are equal")
} else {
  print("a is greater than b")
}

x <- 41

if (x > 10) {
  print("Above ten")
  if (x > 20) {
    print("and also above 20!")
  } else {
    print("but not above 20.")
  }
} else {
  print("below 10.")
}

a <- 200
b <- 20
c <- 300

if (a > b & c > a) {
  print("Both conditions are true")
}

if (a > b | a > c) {
  print("At least one of the conditions is true")
}

# WHILE LOOP
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
}

i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}

i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}

dice <- 1
while (dice <= 6) {
  if (dice < 6) {
    print("No Yahtzee")
  } else {
    print("Yahtzee!")
  }
  dice <- dice + 1
}

# FOR LOOPS
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  print(x)
}

for (x in fruits) {
  if (x == "banana") {
    next
  }
  print(x)
}

for (x in fruits) {
  if (x == "banana") {
    break
  }
  print(x)
}

# NESTED FOR LOOPS
adj <- list("red", "big", "tasty")
fruits <- list("apple", "banana", "cherry")

for (x in adj) {
  for (y in fruits) {
    print(paste(x, y))
  }
}

# FUNCTIONS
double <- function(givenNumber = 1) { # has a default parameter of 1
  print(givenNumber + givenNumber)
}

double()
double(2)

divide <- function(givenNumber, numberToDivideBy) {
  return(givenNumber / numberToDivideBy)
}

print(divide(20, 2))

# NESTED FUCTIONS
Nested_function <- function(x, y) {
  a <- x + y
  return(a)
}

Nested_function(Nested_function(2,2), Nested_function(3,3))

Outer_func <- function(x) {
  Inner_func <- function(y) {
    a <- x + y
    return(a)
  }
  return (Inner_func)
}

output <- Outer_func(3) # To call the Outer_func
output(5)

# RECURSION
tri_recursion <- function(k) {
  if (k > 0) {
    result <- k + tri_recursion(k - 1)
    print(result)
  } else {
    result = 0
    return(result)
  }
}
tri_recursion(6)

# GLOBAL VARIABLES
txt <- "lala"

my_function <- function() {
  txt <<- "fantastic"
  paste("R is", txt)
}

my_function()

print(txt)

# VECTORS (Can only have one data type)
fruits <- c("banana", "apple", "orange", "mango", "lemon")
fruits
sort(fruits)

numbers <- 1:10
numbers
length(numbers)

# Accessing and modifiying vector items
fruits[1]
fruits[1] <- "pear"
fruits

repeat_times <- rep(c(1,2,3), times = 3)
repeat_times

numbers2 <- seq(from = 0, to = 100, by = 20)
numbers2

# LISTS (Can have different data types)
myList <- list("Jason", 5, TRUE)
myList
myList[1]

length(myList)

"Jason" %in% myList

append(myList, "Orange")

append(myList, "night", after = 2)

newlist <- myList[-1]

for (x in myList) {
  print(x)
}

list1 <- list("a", "b", "c")
list2 <- list(1,2,3)
list3 <- c(list1,list2)

list3