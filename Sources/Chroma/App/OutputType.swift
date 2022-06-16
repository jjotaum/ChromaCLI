//
//  OutputType.swift
//  Chroma
//
//  Created by Jota Uribe on 8/06/20.
//  Copyright © 2020 Jota Uribe. All rights reserved.
//

import Foundation
import ArgumentParser

enum OutputType: String, CaseIterable, ExpressibleByArgument {
    case `extension`
    case `struct`
}

extension OutputType {
    
    private static var formattedValues: String {
        return OutputType.allCases.map { "\"\($0.rawValue)\"" }.joined(separator: ",")
    }
    
    static var help: ArgumentHelp {
        """
        Specifies generated file type.
        Supported values: \(formattedValues).
        """
    }
}
