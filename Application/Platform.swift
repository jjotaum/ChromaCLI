//
//  Platform.swift
//  Chroma
//
//  Created by Oscar De Moya on 7/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import Foundation
import ArgumentParser

enum Platform: String, ExpressibleByArgument {
    
    case iOS
    case macOS
    case swiftUI
    
}

extension Platform {
    
    var framework: String {
        switch self {
        case .iOS: return "UIKit"
        case .macOS: return "AppKit"
        case .swiftUI: return "SwiftUI"
        }
    }
    
    var variableType: String {
        switch self {
        case .iOS: return "UIColor"
        case .macOS: return "NSColor"
        case .swiftUI: return "Color"
        }
    }
    
    func colorVariable(name: String) -> String {
        switch self {
        case .iOS, .macOS:
            return "static var \(name): \(variableType) { return \(variableType)(named: \"\(name)\")! }"
        case .swiftUI:
            return "static var \(name): \(variableType) { return \(variableType)(\"\(name)\") }"
        }
    }
    
    func fileContent(header: String, body: String) -> String {
        """
        import \(framework)
        
        \(header) {
        
        \(body)
        
        }
        """
    }
    
}
