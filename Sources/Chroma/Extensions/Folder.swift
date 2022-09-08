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
    static let root: Folder = {
        guard let folder = try? Folder(path: "") else {
            fatalError("Error: Could not create root folder.")
        }
        return folder
    }()
}
