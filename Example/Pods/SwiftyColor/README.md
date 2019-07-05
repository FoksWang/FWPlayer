SwiftyColor
===========

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Build Status](https://travis-ci.org/devxoul/SwiftyColor.svg)](https://travis-ci.org/devxoul/SwiftyColor)
[![CocoaPods](http://img.shields.io/cocoapods/v/SwiftyColor.svg?style=flat)](http://cocoapods.org/?q=name%3ASwiftyColor%20author%3Adevxoul)

The most sexy way to use colors in Swift. Both compatible with iOS and macOS.

Color from Hex
--------------

```swift
let color = 0x123456.color
```

Alpha Operator
--------------

Use infix operator `~`.

```swift
let transparent = 0x123456.color ~ 50%
let red = UIColor.red ~ 10%
let float = UIColor.blue ~ 0.5 // == 50%
```

Percent Operator
----------------

```swift
let view = UIView()
view.alpha = 30% // == 0.3
```

License
-------

SwiftyColor is under MIT license. See LICENSE file for more information.
