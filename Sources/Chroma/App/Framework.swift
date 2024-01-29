//
//  Framework.swift
//  Chroma
//
//  Created by Jota Uribe on 16/10/23.
//

import Foundation
import ArgumentParser

enum Framework: String, CaseIterable, ExpressibleByArgument {
    case AppKit
    case SwiftUI
    case UIKit
}

extension Framework {
    static var help: ArgumentHelp {
        """
        The framework compatibility of generated .swift file.
        Supported values: \(formattedValues).
        """
    }
}

extension Framework {
    var defaultValue: String {
        switch self {
        case .UIKit, .AppKit:
            return "?? .clear "
        case .SwiftUI:
            return ""
        }
    }
    
    var parameterName: String {
        switch self {
        case .UIKit, .AppKit:
            return "named: "
        case .SwiftUI:
            return ""
        }
    }
    
    var variableType: String {
        switch self {
        case .UIKit: return "UIColor"
        case .AppKit: return "NSColor"
        case .SwiftUI: return "Color"
        }
    }
    
    var systemReservedVariableNames: [String] {
        switch self {
        case .UIKit, .AppKit:
            return []
        case .SwiftUI:
            return ["accentColor"]
        }
    }
    
    func colorVariable(name: String) -> String? {
        let formattedName = name.camelCased().removing(.punctuationCharacters.union(.symbols))
        guard !systemReservedVariableNames.contains(formattedName) else { return nil }
        return "    static var \(formattedName): \(variableType) { return \(variableType)(\(parameterName)\"\(name)\") \(defaultValue)}"
    }
}
