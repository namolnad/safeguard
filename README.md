# Safeguard
A lightweight framework which extends `Optional` and plugs into your existing logging system to help identify issues lost in Swift's `guard` statements.

## About
**Safeguard** is designed to be helpful for those who are interested in logging *(and/or utilizing custom handling)* when a `guard` statement has protected an app from a crash.

Per Swift conventions, `guard` allows us as developers to ensure certain conditions exist prior to executing a block of code. It does not, however, let you know this issue has arisen unless you have been diligent about explicitly handling the `else` portion of each `guard` statement. By utilizing **Safeguard**'s `safeguard()` function in mission-critical areas of your code, it helps you to easily capture and log those silent failures so you can learn about and catch these problems before your users **FREAK OUT**. 😱

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

testFunction() // Logs filename, caller/function name, line # for anotherString, and type (String here)
```
By separating cascading `let` statements onto separate lines we can log the line number to the specific failed assignment/unwrap in the guard statement. Without this, it can be difficult to tell which unwrap may have failed.

## Installation
### Carthage
 * Add **Safeguard** to your `Cartfile`:
```Ruby
 github "namolnad/safeguard" 
```
 * Update `Cartfile.resolved` file: `carthage update safeguard`
 * Bootstrap **Safeguard** only: `carthage bootstrap safeguard --no-use-binaries --platform iOS`
 * For each of your build targets, make sure to add `Safeguard.framework` (found in the Carthage build directory) to your project's Build Phases under `Link Binary With Libraries` and in the `Carthage` section (adding `$(SRCROOT)/Carthage/Build/iOS/Safeguard.framework`)
 
### Cocoapods
 * Add **Safeguard** to your `Podfile`:
```Ruby
target 'MyApp' do
  use_frameworks!
  pod 'Safeguard'
end
```
 * Run `pod install`

## Configuration
In your `AppDelegate` file or `AppConfigurator` (depending on your app's setup at launch), the ideal place to setup **Safeguard** is in `application(didFinishLaunchingWithOptions:)`. Simply add `import Safeguard` at the top of your `AppDelegate` file and call the Safeguard configure function (see the example below.) Each of the parameters is `Optional` and has a default value. 
```Swift
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Safeguard.configure(logger: myLogger, customLoggingParams: safeguardParams, nilHandler: { isDebug in
        if isDebug {
            presentLocalAlert()
        }
    })
}
```
##### Logging
If you declare protocol conformance to `SafeLogger` for your existing logger, you can add it as a parameter in Safeguard's configure function. Without this, the default behavior is to print to console, unless the instance's logger is set manually: `Safeguard.instance.logger = nil` (setting to nil will remove default console logging.)

##### Custom Params
At configuration, Safeguard takes a `[String: Any]` param, which can be used to pass up additional useful information at the time of logging, such as custom session info. If nothing is passed here, only the default parameters will be logged, which are: `#file`, `#line`, `#function` and `Wrapped.Type`.
The custom params can also be set directly, if needed: `Safeguard.instance.customLoggingParams = ["Crazy": "Info"]`

##### Nil Handler
Lastly, the `configure` function takes an optional `nilHandler`, which is a closure that takes a `Bool` and returns nothing — `((Bool) -> Void)?`. After logging has executed, this convenience callback is called (if non-nil) everytime an `Optional` has failed to unwrap. If the DEBUG flag has been set by your preprocessor macros, you will also get the additional information of whether the app is running in DEBUG mode (which defaults to false if the flag has not been set, FYI.)

This callback can be useful for scenarios where you perhaps want to cause a crash, or present an alert during development, so you can be sure you notice the issue immediately. Similarly to above, this can be set directly:
```Swift
Safeguard.instance.nilHandler = { isDebug in
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
