//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Swiftline

let splashService = SplashService()

do {
    let type = choose("Select a layout: ", type: SplashService.SplashType.self) { settings in
        let types: [SplashService.SplashType] = [.iPhone4s, .iPhone5s]
        types.forEach { type in settings.addChoice(type.rawValue) { return type } }
    }
    try splashService.run(with: type)
    print("🏄🏻 The project was successfully updated. Don't forget to remove a new files and return splash screen name before committing.")
}
catch {
    print("❌ An error occurred:\n\(error.localizedDescription)")
}
