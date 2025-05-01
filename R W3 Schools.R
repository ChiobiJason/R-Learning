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