//
//  Chroma.swift
//  Chroma
//
//  Created by Jota Uribe on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import ArgumentParser
import Foundation

public struct Chroma: ParsableCommand {
    @Option(name: .shortAndLong, help: "The path of .xcasset file.")
    private var asset: String
    
    @Option(name: .shortAndLong, help: "The path of the generated .swift file.")
    private var path: String
    
    @Option(name: .shortAndLong, help: OutputType.help)
    private var type: OutputType = .extension
    
    @Option(name: .long, help: Framework.help)
    private var framework: Framework = .SwiftUI
    
    public init() {}
    
    public func run() throws {
        let generator = FileGenerator(
            asset: asset,
            path: path,
            type: type,
            framework: framework
        )
        let file = try generator.generate()
        print(
            """
            \(file.name) was generated successfully.
            Can be found at \(file.path)
            """
        )
    }
    
}
