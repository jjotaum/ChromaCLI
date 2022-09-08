//
//  StringFormatterTests.swift
//  Chroma
//
//  Created by Jota Uribe on 7/09/22.
//

import XCTest
@testable import Chroma

class StringFormatterTests: XCTestCase {
    func test_lowercasingFirst_outputValue() {
        let string = "FileNameExample"
        XCTAssertEqual(string.lowercasingFirst(), "fileNameExample")
    }
    
    func test_camelCased_outputValue() {
        let string = "File Name Example"
        XCTAssertEqual(string.camelCased(), "fileNameExample")
    }
    
    func test_removingCharacterSet_outputValue() {
        let string = "File Name Example.ext"
        XCTAssertEqual(string.removing(.whitespaces), "FileNameExample.ext")
    }
    
    static var allTests = [
        ("test_lowercasingFirst_outputValue", test_lowercasingFirst_outputValue),
        ("test_camelCased_outputValue", test_camelCased_outputValue),
        ("test_removingCharacterSet_outputValue", test_removingCharacterSet_outputValue)
    ]
}
