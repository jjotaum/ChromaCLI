//
//  Platform.swift
//  Chroma
//
//  Created by Oscar De Moya on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import Foundation
import ArgumentParser
import Files

enum Platform: String, ExpressibleByArgument {
    case iOS
    case macOS
    case swiftUI
}

extension Platform {
    private static let colorAssetExtension = "colorset"
    
    var framework: String {
        switch self {
        case .iOS: return "UIKit"
        case .macOS: return "AppKit"
        case .swiftUI: return "SwiftUI"
        }
    }
    
    var defaultValue: String {
        switch self {
        case .iOS, .macOS:
            return "?? .clear "
        case .swiftUI:
            return ""
        }
    }
    
    var parameterName: String {
        switch self {
        case .iOS, .macOS:
            return "named: "
        case .swiftUI:
            return ""
        }
    }
    
    var variableType: String {
        switch self {
        case .iOS: return "UIColor"
        case .macOS: return "NSColor"
        case .swiftUI: return "Color"
        }
    }
    
    func fileContent(header: String, body: String) -> String {
        """
        //
        //  Generated by Chroma.
        //  https://github.com/jjotaum/Chroma.
        //
        //  This file was auto generated please do not modify it directly.
        //

        import \(framework)
        
        \(header) {
        
        \(body)
        
        }
        """
    }
    
    func fileBody(asset: Folder) -> Array<String> {
        let assetKey = asset.nameExcludingExtension
        // Get subfolders with valid extension
        let colorSubfolders = asset.subfolders.recursive.filter { $0.extension == Self.colorAssetExtension }
        // Group them by parent name to use them as MARK's
        let parents = Dictionary(grouping: colorSubfolders, by: \.parent?.nameExcludingExtension)
        var content: [String] = []
        // Add main variables
        if let root = parents[assetKey] {
            content.append(contentsOf: colorVariableNames(folders: root))
        }
        // Sort keys to give output MARKS alphabetical order
        parents.sorted(by: { $0.key ?? "" < $1.key ?? "" }).forEach { (key, value) in
            guard key != assetKey else { return }
            if let mark = key {
                content.append("    // MARK: - \(mark)")
            }
            // Add MARK variables
            content.append(contentsOf: colorVariableNames(folders: value))
        }
        return content
    }
    
    private func colorVariableNames(folders: [Folder]) -> [String] {
        // We filter out duplicated variable names
        Set(folders.map { colorFolder in
            return colorVariable(name: colorFolder.nameExcludingExtension)
        }).sorted()
    }
    
    func colorVariable(name: String) -> String {
        let formattedName = name.camelCased().removing(.punctuationCharacters.union(.symbols))
        return "    static var \(formattedName): \(variableType) { return \(variableType)(\(parameterName)\"\(name)\") \(defaultValue)}"
    }
}
