//
//  Folder.swift
//  Chroma
//
//  Created by Oscar De Moya on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import Foundation
import Files

extension Folder {
    
    private static let colorAssetExtension = "colorset"
    
    static let root: Folder = {
        guard let folder = try? Folder(path: "") else {
            fatalError("Error: Could not create root folder.")
        }
        return folder
    }()
    
    func fileBody(for platform: Platform) -> Array<String> {
        let colorSubfolders = subfolders.recursive.filter { $0.extension == Folder.colorAssetExtension }
        let parents = Dictionary(grouping: colorSubfolders, by: \.parent?.nameExcludingExtension)
        var content: [String] = []
        if let root = parents[nameExcludingExtension] {
            content.append(contentsOf: colorVariableNames(platform: platform, folders: root))
        }
        parents.sorted(by: { $0.key ?? "" < $1.key ?? "" }).forEach { (key, value) in
            guard key != nameExcludingExtension else { return }
            if let mark = key {
                content.append("    // MARK: - \(mark)")
            }
            content.append(contentsOf: colorVariableNames(platform: platform, folders: value))
        }
        return content
    }
    
    private func colorVariableNames(platform: Platform, folders: [Folder]) -> [String] {
        // We filter out duplicated variable names
        Set(folders.map { colorFolder in
            return platform.colorVariable(name: colorFolder.nameExcludingExtension)
        }).sorted()
    }
}
