//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground!"
print(str)

let now = Date()
print(now)

var shoppingList = ["coffee" : 3, "candy" : 4]
for (item, amount) in shoppingList {
    print("\(item) : \(amount)")
}

var myOptionalString:String? = "Hello"
print(myOptionalString!)

func someFunction (foo: Float) -> Float { // the -> Float describes the return type
    let blah = 2 * foo
    return blah
}

print(someFunction(foo: 5.5))

