//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import xcproj
import Files
import PathKit

public final class SplashService {

    public enum Error: Swift.Error, LocalizedError {
        case missingProject
        case cannotFindConfiguration(name: String)
        case cannotReadInfo
        case cannotFindRootGroup

        public var errorDescription: String? {
            switch self {
            case .missingProject: return "Can't find .xcodeproj in current directory."
            case let .cannotFindConfiguration(name: name): return "Can't find \(name) configuration in the project."
            case .cannotReadInfo: return "Can't read data from Info.plist"
            case .cannotFindRootGroup: return "Can't find Root group in the project."
            }
        }
    }

    private enum Constants {
        static let projectExtension = ".xcodeproj"
        static let reference = "06B7C9B61F9738E100DAB44D"
        static let launchStoryboardString = "\t<key>UILaunchStoryboardName</key>\n\t<string>LaunchScreen</string>\n"
    }

    public enum Layout: String {
        case iPhone4s = "320x480"
        case iPhone5s = "320x568"

        var fileName: String {
            switch self {
            case .iPhone4s:
                return "Default@2x.png"
            case .iPhone5s:
                return "Default-568h@2x.png"
            }
        }
    }

    private let fileSystem: FileSystem

    public init(fileSystem: FileSystem = .init()) {
        self.fileSystem = FileSystem()
    }

    public func run(with layout: Layout) throws {
        let currentFolder = fileSystem.currentFolder
        let projectFile = currentFolder.subfolders.first { $0.name.contains(Constants.projectExtension) }
        guard let unwrappedProjectFile = projectFile else {
            throw Error.missingProject
        }

        let project = try XcodeProj(pathString: unwrappedProjectFile.name)

        let infoPath = try infoFilePath(from: project, forConfigurationName: "Debug")
        do {
            let infoFile = try File(path: currentFolder.path + infoPath)
            let infoString = try infoFile.readAsString()
            try infoFile.write(string: infoString.replacingOccurrences(of: Constants.launchStoryboardString, with: ""))
        }
        catch {
            throw Error.cannotReadInfo
        }

        let fileName = layout.fileName
        try currentFolder.createFile(named: fileName)
        try addImageFile(withName: fileName, to: project)
        let projectPath = Path(unwrappedProjectFile.name)
        try project.write(path: projectPath, override: true)
    }

    private func addImageFile(withName name: String, to project: XcodeProj) throws {
        let fileReference = PBXFileReference(reference: Constants.reference,
                                             sourceTree: .group,
                                             lastKnownFileType: "image.png",
                                             path: name)
        project.pbxproj.fileReferences.append(fileReference)
        let group = project.pbxproj.groups.first { $0.name == nil && $0.path == nil }
        guard let unwrappedGroup = group else {
            throw Error.cannotFindRootGroup
        }
        unwrappedGroup.children.insert(Constants.reference, at: 0)
    }

    private func infoFilePath(from project: XcodeProj, forConfigurationName configurationName: String) throws -> String {
        let debugConfiguration = project.pbxproj.buildConfigurations.filter { $0.name == configurationName }.last
        guard let unwrappedDebugConfiguration = debugConfiguration else {
            throw Error.cannotFindConfiguration(name: configurationName)
        }
        guard let infoFilePath = unwrappedDebugConfiguration.buildSettings["INFOPLIST_FILE"] as? String else {
            throw Error.cannotReadInfo
        }
        return infoFilePath
    }
}
