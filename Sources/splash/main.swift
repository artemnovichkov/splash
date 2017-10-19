//
//  Copyright © 2017 Rosberry. All rights reserved.
//

let splashService = SplashService()

do {
    try splashService.run(with: .iPhone4s)
    print("🏄🏻 The project was successfully updated. Don't forget to remove a new files and return splash screen name before committing.")
}
catch {
    print("❌ An error occurred:\n\(error.localizedDescription)")
}
