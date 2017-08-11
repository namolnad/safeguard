# Safeguard [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/namolnad/safeguard.svg?branch=master)](https://travis-ci.org/namolnad/safeguard)
A lightweight framework which extends `Optional` and plugs into your existing logging system to help identify issues lost in Swift's `guard` statements.

![Safeguard](safeguard.png "Safeguard")

## About
**Safeguard** is designed to be helpful for those who are interested in logging *(and/or utilizing custom handling)* when a `guard` statement has protected an app from a crash.

Per Swift conventions, `guard` allows us as developers to ensure certain conditions exist prior to executing a block of code. It does not, however, let you know this issue has arisen unless you have been diligent about explicitly handling the `else` portion of each `guard` statement. By utilizing **Safeguard**'s `safeguard()` function in mission-critical areas of your code, it helps you to easily capture and log those silent failures so you can learn about and catch these problems before your users **FREAK OUT**. 😱

## Example Usage
```Swift
import Safeguard

let optionalString: String? = "Hi there"
let anotherString: String? = nil

func testFunction() {
    guard let optionalString = optionalString.safeguard(),
          let anotherString = anotherString.safeguard("anotherString") else {
        return
    }

    print("This is \(optionalString) and \(anotherString) in a sentence.")
}

testFunction() // Logs label (passed as "anotherString" here), filename, caller/function name, line # for anotherString, and type (String here)
```
By separating cascading `let` statements onto separate lines we can log the line number to the specific failed assignment/unwrap in the guard statement. Without this, it can be difficult to tell which unwrap may have failed.

## Installation
### Carthage
 * Add **Safeguard** to your `Cartfile`:
```Ruby
 github "namolnad/safeguard" 
```
 
### Cocoapods
 * Add **Safeguard** to your `Podfile`:
```Ruby
target 'MyApp' do
  use_frameworks!
  pod 'Safeguard'
end
```

## Configuration
In your `AppDelegate` file or `AppConfigurator` (depending on your app's setup at launch), the ideal place to setup **Safeguard** is in `application(didFinishLaunchingWithOptions:)`. Simply add `import Safeguard` at the top of your `AppDelegate` file and call the Safeguard `configure()` function (see the example below.) Each of the parameters is `Optional` and has a default value of `nil`, allowing you the flexibility to configure only a single, specific parameter with each `configure()` call, if you so choose. Safeguard parameters passed `nil` or left empty in the `configure()` function, will not be modified. 
```Swift
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Safeguard.configure(logger: myLogger, customLoggingParams: safeguardParams, nilHandler: safeguardNilHandler)
        return true
}
```
##### Logging
By default, no logger is set. You can use our basic console logger `SafeLogger` by creating an instance and passing it to Safeguard's `configure()` function. 
```Swift
let myLogger = SafeLogger()
```
If you have needs beyond console logging, we recommend using a more robust logger (here at Instacart we use [Willow](https://github.com/Nike-Inc/Willow)). If your existing logger conforms to Safeguard's `SafeLoggable` protocol, you can pass it as a parameter in Safeguard's `configure()` function.

##### Custom Params
At configuration, Safeguard takes a `[String: Any]` param, which can be used to pass up additional useful information at the time of logging, such as custom session info. If nothing is passed here, only the default parameters will be logged, which are: `#file`, `#line`, `#function` and `Wrapped.Type`.  
```Swift
let safeguardParams: [String: Any] = ["Crazy": "Info"]
```

##### Nil Handler
Lastly, the `configure()` function takes an optional `nilHandler`, which is a closure that takes a `Bool` and returns nothing — `((Bool) -> Void)?`. After logging has executed, this convenience callback is called (if non-nil) everytime an `Optional` has failed to unwrap. If the DEBUG flag has been set by your preprocessor macros, you will also get the additional information of whether the app is running in DEBUG mode (which defaults to `false` if the flag has not been set, FYI.)

This callback can be useful for scenarios where you perhaps want to cause a crash, or present an alert during development, so you can be sure you notice the issue immediately.
```Swift
let safeguardNilHandler: (Bool) -> Void = { isDebug in
    if isDebug {
        assertionFailure()
    }
}
```

That's all for now, happy `safeguard()`ing!

## Want to Help Improve Safeguard?
That’s awesome! Here are a couple of ways you can help:

 * [Report issues or suggest new features](https://github.com/namolnad/safeguard/issues)
 * Write bug fixes and improvements and submit [pull requests](https://github.com/namolnad/safeguard/pulls)
