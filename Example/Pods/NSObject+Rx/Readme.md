[![CircleCI](https://circleci.com/gh/RxSwiftCommunity/NSObject-Rx/tree/master.svg?style=svg)](https://circleci.com/gh/RxSwiftCommunity/NSObject-Rx/tree/master)

NSObject+Rx
===========

If you're using [RxSwift](https://github.com/ReactiveX/RxSwift), you've probably encountered the following code more than a few times.

```swift
class MyObject: Whatever {
	let disposeBag = DisposeBag()

	...
}
```

You're actually not the only one; it has been typed many, many times.

[![Search screenshot showing many, many results.](assets/screenshot.png)](https://github.com/search?q=let+disposeBag+%3D+DisposeBag%28%29&type=Code&utf8=✓)

Instead of adding a new property to every object, use this library to add it for you, to any subclass of `NSObject`.

```swift
thing
  .bind(to: otherThing)
  .disposed(by: rx.disposeBag)
```

Sweet.

It'll work just like a property: when the instance is deinit'd, the `DisposeBag` gets disposed. It's also a read/write property, so you can use your own, too.

If you want to add a DisposeBag to an Object that does not inherit from NSObject, you can also implement the protocol `HasDisposeBag`, and you're good to go. This protocol provides a default DisposeBag called `disposeBag`.

Installing
----------

#### CocoaPods

Add to your `Podfile`:

```ruby
pod 'NSObject+Rx'
```

And that'll be 👌

#### Carthage

Add to `Cartfile`:
```
github "RxSwiftCommunity/NSObject-Rx"
```
Add frameworks to your project (no need to "copy items if needed")

Run `carthage update` or `carthage update --platform ios` if you target iOS only

Add run script build phase `/usr/local/bin/carthage copy-frameworks`
with input files being:

```
$(SRCROOT)/Carthage/Build/iOS/RxSwift.framework
$(SRCROOT)/Carthage/Build/iOS/NSObject_Rx.framework
```

And rule ✌️

Contributing
------------

Source files are in the root directory. We use CocoaPods to develop, check out the unit tests in the Demo project.

License
-------

MIT obvs.

![Tim Cook dancing to the sound of a permissive license.](http://i.imgur.com/mONiWzj.gif)
