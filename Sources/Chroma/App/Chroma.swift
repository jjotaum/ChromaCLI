//
//  Chroma.swift
//  Chroma
//
//  Created by Jota Uribe on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import ArgumentParser
import Files
import Foundation

public struct Chroma: ParsableCommand {
    @Option(name: .shortAndLong, help: "The path of .xcasset file.")
    private var asset: String
    
    @Option(name: .shortAndLong, help: "The path of the generated .swift file.")
    private var path: String
    
    @Option(name: .shortAndLong, default: .extension, help: OutputType.help)
    private var type: OutputType
    
    @Option(name: .long, default: .iOS, help: "Specifies the platform compatibility of the exported file.\niOS, macOS, swiftUI")
    private var platform: Platform
    
    public init() {}
    
    public func run() throws {
        try generate()
    }
    
}

extension Chroma {
    
    private func generate() throws {
        let outputFile = try outputFile()
        let content = try getContentFromAssetsFile(outputFile: outputFile)
        try outputFile.write(content)
        print(
            """
            \(outputFile.name) was generated successfully.
            Can be found at \(outputFile.path)
            """
        )
    }
    
    private func outputFile() throws -> File {
        guard let pathURL = URL(string: path), !pathURL.hasDirectoryPath, pathURL.pathExtension == "swift"  else {
            throw ChromaError.invalidPath(path: path)
        }
        
        
        let folder = try Folder(path: pathURL.deletingLastPathComponent().path)
        return File(named: pathURL.lastPathComponent, at: folder)
    }
    
    private func getContentFromAssetsFile(outputFile: File) throws -> String {
        let folder = try Folder(path: asset)
        let body = folder.colorDefinitions(for: platform).sorted().joined(separator: "\n")
        return platform.fileContent(header: header(file: outputFile), body: body)
    }
    
    private func header(file: File) -> String {
        switch type {
        case .extension:
            return "\(type.rawValue) \(platform.variableType)"
        case .struct:
            return "\(type.rawValue) \(file.nameExcludingExtension)"
        }
    }
}
