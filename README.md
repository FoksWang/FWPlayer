<p align="center" >
  <img src="GitImages/github_logo.png" alt="FWPlayer" title="FWPlayer">
</p>

![Swift5](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat%22)
[![Version](https://img.shields.io/cocoapods/v/FWPlayer.svg?style=flat)](https://cocoapods.org/pods/FWPlayer)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/FWPlayer.svg?style=flat)](https://cocoapods.org/pods/FWPlayer)
[![Platform](https://img.shields.io/cocoapods/p/FWPlayer.svg?style=flat)](https://cocoapods.org/pods/FWPlayer)

# FWPlayer
A video player SDK for iOS, it is based on AVPlayer. 

## Features
- [x] Supports horizontal and vertical playback
- [x] Supports auto-rotating screen playback
- [x] Supports the full-screen and mini-player playback
- [x] Supports mini-player position to drag freely
- [x] Supports the network and local video playback
- [x] Supports full-screen lock
- [x] Supports playback while downloading (Media Cache)
- [x] Supports vertical slide on the left side of the screen to adjust the brightness
- [x] Supports the vertical slide on the right side of the screen to adjust the volume
- [x] Supports gesture swipe fast-forward and rewind
- [x] Supports drag slider fast-forward and rewind
- [x] Supports direct jump to a point in the timeline to play
- [x] Supports multiple video formats
- [x] Supports UITableView playback
- [x] Supports UICollectionView playback
- [x] Supports UIScrollView playback
- [x] Supports background playback
- [x] Supports play sound in silent mode by default
- [x] Supports speed rate playback (0.5x, 1.0x, 1.25x, 1.5x, 2.0x)
- [x] Supports custom player view
- [x] Supports advertising view
- [x] Supports adding Http headers and other options to AVURLAsset
- FFmpeg is not supported because OpenGL ES was deprecated in iOS 12

## Requirements
- iOS 9 +
- Xcode 10.2.1 +

## Installation

You can install FWPlayer SDK in several ways:

1. [CocoaPods](#cocoapods)
2. [Carthage](#carthage)
3. [Manual Installation](#manual-installation)

### CocoaPods

[CocoaPods](http://www.cocoapods.org/) is an easy way to install FWPlayer.

1. Add following pod to your `Podfile`:

```ruby
platform :ios, '9.0'

target 'Your App' do
    pod 'FWPlayer'
end
```

2. Then, run the following command:
```bash
$ pod install
```

### Carthage

Since FWPlayer SDK is distributed as a binary, you need to use custom `binary` rule in your `Cartfile`.

1. Add following to your `Cartfile`:

```
binary "https://raw.githubusercontent.com/FoksWang/FWPlayer/master/Carthage/FWPlayer.json" >= 1.0.6
```

2. Fetch framework by running:

```bash
$ carthage update FWPlayer --platform iOS
```

### Manual Installation

1. Add the FWPlayer framework to `Embedded Binaries` for your target:

```
FWPlayerCore.framework
```

2. Make sure you link with the following `Linked Frameworks and Libraries`:

```
FWPlayerCore.framework
```

## Usage

### Normal Style
**Objective-C**
```objective-c
FWAVPlayerManager *playerManager = [[FWAVPlayerManager alloc] init];
self.player = [FWPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
self.player.controlView = self.controlView;
```

**Swift**
```swift
let playerManager = FWAVPlayerManager()
self.player = FWPlayerController(playerManager: playerManager, containerView: self.containerView)
self.player!.controlView = self.controlView
```

### List Style
**Objective-C**
```objective-c
FWAVPlayerManager *playerManager = [[FWAVPlayerManager alloc] init];
self.player = [FWPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:tag];
self.player.controlView = self.controlView;
```

**Swift**
```swift
let playerManager = FWAVPlayerManager()
self.player = FWPlayerController(scrollView: tableView, playerManager: playerManager, containerViewTag: tag)
self.player!.controlView = self.controlView
```

- Your custom playerManager must conform to `FWPlayerMediaPlayback` protocol.
- Your custom controlView must conform to `FWPlayerMediaControl` protocol.

### Must implement in the ViewController if video rotating
**Objective-C**
```objective-c
- (BOOL)shouldAutorotate {
    return player.shouldAutorotate;
}
```

**Swift**
```swift
override var shouldAutorotate: Bool {
  return self.player?.shouldAutorotate ?? false
}
```

### If use playback while downloading (Media Cache)

The function `playback while downloading (Media Cache)` does **NOT** support m3u8, it is commonly used for MP4.

1. Setup `isEnableMediaCache`

**Objective-C**
```objc
playerManager.isEnableMediaCache = YES;
```

**Swift**
```swift
playerManager.isEnableMediaCache = true
```

2. Setup `NSAppTransportSecurity` in your `Info.plist`
```plist
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## Demonstration
<img src="GitImages/Screenshot1.jpg" height="500"> <img src="GitImages/Screenshot2.jpg" height="500"> <img src="GitImages/Screenshot3.jpg" height="500">

## References
- https://github.com/Bilibili/ijkplayer
- https://github.com/changsanjiang/SJVideoPlayer
- https://github.com/renzifeng/ZFPlayer
- https://github.com/vitoziv/VIMediaCache
- https://github.com/ChangbaDevs/KTVHTTPCache

## Author

(Foks)Hui Wang, foks.wang@gmail.com

## License

FWPlayer is available under the MIT license. See the LICENSE file for more info.
