# Safeguard
A simple extension on `Optional` to help identify issues lost in Swift's `guard` statements

## About
This code has been provided as an example to help those who are interested in logging *(or crashing, during development)* when a `guard` statement has protected an app from a crash.

Per Swift conventions, `guard` allows us as developers to ensure certain conditions exist prior to executing a block of code. It does not, however, let the developer know this issue may have arisen without explicit handling in the `else` portion of each `guard` statement.

By utilizing this `safeguard()` function in mission-critical areas of your code, it helps you to log (in the wild) or crash (in development) so you can learn about and catch these problems before your users **FREAK OUT**. 😱

Long-term plans for this code are to roll it out in a more robust framework which will include flexible logging options. For the time being, it is meant more as a simple extension for you to copy-paste into your app and adjust to fit with your specific logging needs.

## Example Usage
```Swift
let optionalString: String? = "Hi there"
let anotherString: String? = nil

func testFunction() {
    guard let optionalString = optionalString.safeguard(),
          let anotherString = anotherString.safeguard() else {
        return
    }

    print("This is \(optionalString) and \(anotherString) in a sentence.")
}

testFunction() // Logs filename, caller/function name, and line # for anotherString
```
By separating cascading `let` statements onto separate lines we can get log the line number to the failed assignment/unwrap in the guard statement. Without this, it can be difficult to tell which unwrap may have failed.
