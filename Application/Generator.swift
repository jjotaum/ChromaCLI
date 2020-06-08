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

struct Generator: ParsableCommand {
    
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
        let folder = Folder.root
        let file = File(named: name, at: folder)
        let body = folder.colorDefinitions(for: platform).joined(separator: "\n\n")
        let content = platform.fileContent(body: body)
        try? file.write(content)
    }
    
}
