//
//  String+Formatters.swift
//  Chroma
//
//  Created by Jota Uribe on 7/10/21.
//

import Foundation

extension String {
    func lowercasingFirst() -> String {
        let lowercasedChar = first?.lowercased() ?? ""
        return String(lowercasedChar + dropFirst())
    }
    
    func camelCased() -> String {
        var nameComponents = components(separatedBy: " ")
        guard var formattedName = nameComponents.first?.lowercasingFirst() else { return self }
        nameComponents.removeFirst()
        for nameComponent in nameComponents {
            formattedName += nameComponent.capitalized
        }
        return formattedName
    }
    
    func removing(_ characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }
}
