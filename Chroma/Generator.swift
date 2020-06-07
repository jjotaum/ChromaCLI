//
//  Generator.swift
//  Chroma
//
//  Created by Jota Uribe on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import Foundation
import ArgumentParser
import Files

enum Platform: String, ExpressibleByArgument {
    case iOS, macOS, swiftUI
}

struct Generator: ParsableCommand {
    
    private let colorAssetExtension = "colorset"
    
    @Option(name: .shortAndLong, default: "Chroma", help: "Defines the name of the generated file.")
    private var name: String
    
    @Option(name: .shortAndLong, default: .iOS, help: "Specifies the platform compatibility of the exported file.")
    private var platform: Platform
    
    func run() throws {
        generate()
    }
}

extension Generator {
    
    private func generate() {
        do {
            let rootFolder = try Folder(path: "")
            let colorSubfolders = rootFolder.subfolders.recursive.filter({ $0.extension == colorAssetExtension })
            let colorsDefinitions = Set(colorSubfolders.map { colorFolder  in
                return platform.colorVariable(name: colorFolder.nameExcludingExtension)
            })
            
            let generatedFile = try rootFolder.createFileIfNeeded(at: "\(name).swift")
            let paletteFileHeader = platform.fileHeader(body: colorsDefinitions.joined(separator: "\n\n"))
            try generatedFile.write(paletteFileHeader)
        } catch {
            print(error)
        }
    }
}

private extension Platform {
    
    var framework: String {
        switch self {
        case .iOS:
            return "UIKit"
        case .macOS:
            return "AppKit"
        case .swiftUI:
            return "SwiftUI"
        }
    }
    
    var variableType: String {
        switch self {
        case .iOS:
            return "UIColor"
        case .macOS:
            return "NSColor"
        case .swiftUI:
            return "Color"
        }
    }
    
    func colorVariable(name: String) -> String {
        switch self {
        case .iOS, .macOS:
            return "static var \(name): \(variableType) { return \(variableType)(named: \"\(name)\")! }"
        case .swiftUI:
            return "static var \(name): \(variableType) { return \(variableType)(\"\(name)\") }"
        }
    }
    
    func fileHeader(body: String) -> String {
        "import \(framework)\n\nextension \(variableType) {\n\n\(body)\n\n}"
    }
}
