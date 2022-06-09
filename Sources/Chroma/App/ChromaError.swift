//
//  Error.swift
//  
//
//  Created by Jota Uribe on 9/06/22.
//

import Foundation

enum ChromaError: LocalizedError {
    case fileCreationFailed(path: String)
    case invalidPath(path: String)
}

extension ChromaError {
    var errorDescription: String? {
        switch self {
        case .fileCreationFailed(let path):
            return "Could not create file at \(path)"
        case .invalidPath(let path):
            return "Invalid path: \(path)"
        }
    }
}
