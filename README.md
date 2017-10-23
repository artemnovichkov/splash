# 🏊🏻 Splash
![Swift 4](https://img.shields.io/badge/Swift-4-yellow.svg)
![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)
![Make](https://img.shields.io/badge/homebrew-compatible-brightgreen.svg?style=flat)
[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=59ed8ff243aa2a0001c0ba1c&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/59ed8ff243aa2a0001c0ba1c/build/latest?branch=master)

Test different app layouts with only one device.

<p align="center">
<img src=".github/example_iphone4.png" width="250" />
<img src=".github/example_iphone5s.png" width="250" />
<img src=".github/example_default.png" width="250" />
</p>

## Features
- Configuring Xcode project for different layouts

## Using

Run `splash` in a project directory and choose a layout. Don't forget to clean a project with `Cmd+Shift+K` to remove cached splash screens.

## Installing

### Homebrew (recommended):

```bash
$ brew install artemnovichkov/projects/splash
```

### Make:

```bash
$ git clone https://github.com/artemnovichkov/splash.git
$ cd splash
$ make
```

### Swift Package Manager:

```swift
// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Project",
    dependencies: [
    .package(url: "https://github.com/artemnovichkov/splash.git", from: "1.0.0"),
        ],
    targets: [
        .target(
            name: "Project", dependencies: ["splash"])
    ]
)
```

## TODOs:

 - [ ] A command for cleaning: removing added files, return Splash Screen path

## Author

Artem Novichkov, novichkoff93@gmail.com

## License

Splash is available under the MIT license. See the LICENSE file for more info.
