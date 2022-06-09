//
//  FileTests.swift
//  Chroma
//
//  Created by Jota Uribe on 9/06/22.
//

import XCTest
import Files
@testable import Chroma

final class PlatformTests: XCTestCase {
    func testColorVariableForiOS() throws {
        let variable = Platform.iOS.colorVariable(name: "ExampleColor1")
        XCTAssertEqual(variable, "    static var exampleColor1: UIColor { return UIColor(named: \"ExampleColor1\")! }")
    }
    
    func testColorVariableForMacOS() throws {
        let variable = Platform.macOS.colorVariable(name: "ExampleColor1")
        XCTAssertEqual(variable, "    static var exampleColor1: NSColor { return NSColor(named: \"ExampleColor1\")! }")
    }
    
    func testColorVariableForSwiftUI() throws {
        let variable = Platform.swiftUI.colorVariable(name: "ExampleColor1")
        XCTAssertEqual(variable, "    static var exampleColor1: Color { return Color(\"ExampleColor1\") }")
    }

    static var allTests = [
        ("testColorVariableForiOS", testColorVariableForiOS),
        ("testColorVariableForMacOS", testColorVariableForMacOS),
        ("testColorVariableForSwiftUI", testColorVariableForSwiftUI)
    ]
}
