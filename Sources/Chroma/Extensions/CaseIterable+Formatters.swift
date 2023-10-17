//
//  CaseIterable+Formatters.swift
//  Chroma
//
//  Created by Jota Uribe on 17/10/23.
//

import Foundation

extension CaseIterable where Self: RawRepresentable {
    static var formattedValues: String {
        return Self.allCases.map { "\($0.rawValue)" }.joined(separator: ", ")
    }
}
