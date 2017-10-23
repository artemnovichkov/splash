# 🏊🏻 Splash

Test different app layouts with only one device.

<p align="center">
<img src=".github/example_iphone4.png" width="250" />
<img src=".github/example_iphone5s.png" width="250" />
<img src=".github/example_default.png" width="250" />
</p>

## Features
- Configuring Xcode project for different layouts

## Using

Run `splash` in a project directory and choose a layout. Don't forget to clean a project with Cmd+Shift+K to remove cached splash screens.

## Installing

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
 - [ ] Xcode project cleaning like Cmd+Shift+K after execution

## Author

Artem Novichkov, novichkoff93@gmail.com

## License

Splash is available under the MIT license. See the LICENSE file for more info.
