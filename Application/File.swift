//
//  File.swift
//  Chroma
//
//  Created by Oscar De Moya on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import Foundation
import Files

extension File {
    
    init(named name: String, at folder: Folder) {
        guard let file = try? folder.createFileIfNeeded(at: "\(name).swift") else {
            fatalError("Error: Could not create file \(name).swift.")
        }
        self = file
    }
    
}
