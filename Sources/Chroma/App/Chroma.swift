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
    
    @Option(name: .shortAndLong, help: OutputType.help)
    private var type: OutputType = .extension
    
    @Option(name: .long, help: "Specifies the platform compatibility of the exported file.\niOS, macOS, swiftUI")
    private var platform: Platform = .iOS
    
    public init() {}
    
    public func run() throws {
        let outputFile = try createOutputFile()
        let content = try getContentFromAssetsFile(outputFile: outputFile)
        try outputFile.write(content)
        print(
            """
            \(outputFile.name) was generated successfully.
            Can be found at \(outputFile.path)
            """
        )
    }
    
}

extension Chroma {
    private func createOutputFile() throws -> File {
        // Check if path param is a valid swift file path
        guard let pathURL = URL(string: path), !pathURL.hasDirectoryPath, pathURL.pathExtension == "swift"  else {
            throw ChromaError.invalidPath(path: path)
        }
        
        let folder = try Folder(path: pathURL.deletingLastPathComponent().path)
        return try File(named: pathURL.lastPathComponent, at: folder)
    }
    
    private func getContentFromAssetsFile(outputFile: File) throws -> String {
        let assetFolder = try Folder(path: asset)
        let body = platform.fileBody(asset: assetFolder).joined(separator: "\n")
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
