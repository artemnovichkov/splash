//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import xcproj
import Files
import PathKit

final class SplashService {

    enum Error: Swift.Error {
        case missingProject
        case cannotFindConfiguration(name: String)
        case cannotReadInfo
    }

    enum Constants {
        static let projectExtension = ".xcodeproj"
        static let iPhone5FileName = "Default-568h@2x.png"
        static let iPhone4FileName = "Default@2x.png"
        static let reference = "06B7C9B61F9738E100DAB44D"
        static let launchStoryboardString = "\t<key>UILaunchStoryboardName</key>\n\t<string>LaunchScreen</string>\n"
    }

    enum SplashType {
        case iPhone4s
        case iPhone5s

        var fileName: String {
            switch self {
            case .iPhone4s:
                return ""
            case .iPhone5s:
                return ""
            }
        }
    }

    func run() throws {
        let currentFolder = FileSystem().currentFolder
        let projectFile = currentFolder.subfolders.first { $0.name.contains(Constants.projectExtension) }
        guard let unwrappedProjectFile = projectFile else {
            throw Error.missingProject
        }

        //Create file with special name
        let fileName = Constants.iPhone5FileName
        try currentFolder.createFile(named: fileName)

        //Add the file to Xcode project
        let projectPath = Path(unwrappedProjectFile.name)
        let project = try XcodeProj(path: projectPath)
        let fileReference = PBXFileReference(reference: Constants.reference,
                                             sourceTree: .group,
                                             lastKnownFileType: "image.png",
                                             path: fileName)
        project.pbxproj.fileReferences.append(fileReference)
        let group = project.pbxproj.groups.first { $0.name == nil && $0.path == nil }!
        group.children.insert(Constants.reference, at: 0)
        try project.write(path: projectPath, override: true)

        //Remove splash screen name from Info.plist
        let debugConfiguration = project.pbxproj.buildConfigurations.first { $0.name == "Debug" }
        guard let unwrappedDebugConfiguration = debugConfiguration else {
            throw Error.cannotFindConfiguration(name: "Debug")
        }
        guard let infoFilePath = unwrappedDebugConfiguration.buildSettings["INFOPLIST_FILE"] as? String else {
            throw Error.cannotReadInfo
        }
        do {
            let infoFile = try File(path: currentFolder.path + infoFilePath)
            let infoString = try infoFile.readAsString()
            try infoFile.write(string: infoString.replacingOccurrences(of: Constants.launchStoryboardString, with: ""))
        }
        catch {
            throw Error.cannotReadInfo
        }
    }
}