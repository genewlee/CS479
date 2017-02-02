1_17_17

Swift

Similar to Python
	Better than python, except in terms of third-party libraries (for now)

Faster than C++ in many cases
	Can directly call C/C++ code

Xcode has a playground
	Nice to play around and test code

The Swift Tour -> good place to learn (from Apple)

When declaring a variable 
	'let' keyword is immutable (constants)
	'var' keyword is mutable   (variable)

ex:
	var shoppingList = ["coffee" : 3, "candy" : 4]
	for (item, amount) in shoppingList {
		print("\(item) : \(amount)")
	}

Iterating over a Dictionary, order is not defined
Only in arrays are order is defined
Dictionary uses a tree structure

///// OPTIONALS

An optional in Swift is a variable that can hold either a value or no value. 
It would be nice to return a nil when a value is not found in the array. Thus optionals.
Optionals are written by appending a ? to the type:
ex:
	let myOptionalString:String? = "Hello"
	print(myOptionalString) // print(myOptionalString!) -> says that it has a value and not nil

	To get the value from your variable if it is optional, you have to unwrap it. 
	This just means putting an exclamation point at the end
ex:
	let forcedStr: String = possibleStr! // unwrapping
	print(forcedStr) 

	let assumedStr: String! = "Hello" // implicitly unwrapped
	let implicitStr: String = assumedStr // no need for !

///// Range Operators

a...<b

///// Functions

start with func keyword

ex:
	func someFunction (_ foo: Float) -> Float { // the -> Float describes the return type
		let blah = 4.2
		return blah
	}

Undetermined number of parameters
ex:
	func blahFunc (_ numbers: Double...) -> Double {
		var total: Double = 0
		for number in numbers {
			total += number
		}
		return total / Double(numbers.count)
	}

In-out (call by reference)
ex:
	func blahFunc (_ a: inout Int, _ b: inout Int) {
		let tempA = a 
		a = b 
		b = tempA
	}

// Function Types -> assigns functions to another function --> function delegate?

ex:
	func addTwoInts (_ a: Int, _ b: Int) -> Int {
		return a + b
	}

	var mathFunction: (Int, Int) -> Int = addTwoInts

	print("Result: \(mathFunction(2, 3))") // prints "Result: 5"

	func printMathResult (_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
		print("Result: \(mathFunction(a, b))")
	}

	printMathResult(addTwoInts, 3, 5) // prints "Result: 8"


// Closures and escapting Closures

Self-contained block of code
Can capture references to variables in context
General form:
	{ (parameters) -> return-type in 
		statements
	}





