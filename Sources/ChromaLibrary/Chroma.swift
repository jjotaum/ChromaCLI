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
    @Option(name: .shortAndLong, default: "Colors", help: "Defines the name of the generated file.")
    private var name: String
    
    @Option(name: .shortAndLong, default: .extension, help: OutputType.help)
    private var output: OutputType
    
    @Option(name: .shortAndLong, default: .iOS, help: "Specifies the platform compatibility of the exported file.\niOS, macOS, swiftUI")
    private var platform: Platform
    
    private var header: String {
        switch output {
        case .extension:
            return "\(output.rawValue) \(platform.variableType)"
        case .struct:
            return "\(output.rawValue) \(name)"
        }
    }
    
    public init() {}
    
    public func run() throws {
        generate()
    }
    
}

extension Chroma {
    
    private func generate() {
        let folder = Folder.root
        let file = folder.files.recursive.first(where: { $0.name == "\(name).swift" }) ?? File(named: name, at: folder)
        let body = folder.colorDefinitions(for: platform).sorted().joined(separator: "\n\n")
        let content = platform.fileContent(header: header, body: body)
        do {
            try file.write(content)
            print(
                """
                \(file.name) was generated successfully.
                Can be found at \(file.path)
                """
            )
        } catch {
            print(error.localizedDescription)
        }
    }
}
