//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import Swiftline
import SplashCore

let splashService = SplashService()

do {
    let layout = choose("Select a layout: ", type: SplashService.Layout.self) { settings in
        let layouts: [SplashService.Layout] = [.iPhone4s, .iPhone5s]
        layouts.forEach { type in settings.addChoice(type.rawValue) { return type } }
    }
    try splashService.run(with: layout)
    print("🏄🏻 The project was successfully updated. Don't forget to discard all changes before committing.")
}
catch {
    print("❌ An error occurred:\n\(error.localizedDescription)")
}
