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
    static var help: ArgumentHelp {
        """
        The output type of generated .swift file.
        Supported values: \(formattedValues).
        """
    }
}
