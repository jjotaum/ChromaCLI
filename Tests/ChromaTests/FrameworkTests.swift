//
//  FrameworkTests.swift
//  Chroma
//
//  Created by Jota Uribe on 9/06/22.
//

import XCTest
import Files
@testable import Chroma

final class FrameworkTests: XCTestCase {
    func test_framework_outputValues() {
        XCTAssertEqual(Framework.AppKit.rawValue, "AppKit")
        XCTAssertEqual(Framework.UIKit.rawValue, "UIKit")
        XCTAssertEqual(Framework.SwiftUI.rawValue, "SwiftUI")
    }
    
    func test_variableType_outputValues() {
        XCTAssertEqual(Framework.AppKit.variableType, "NSColor")
        XCTAssertEqual(Framework.SwiftUI.variableType, "Color")
        XCTAssertEqual(Framework.UIKit.variableType, "UIColor")
    }
    
    func test_colorVariable_outputValues() throws {
        let variableName = "ExampleColor1"
        var platform: Framework = .AppKit
        XCTAssertEqual(platform.colorVariable(name: variableName), "    static var exampleColor1: NSColor { return NSColor(named: \"ExampleColor1\") ?? .clear }")
        platform = .SwiftUI
        XCTAssertEqual(platform.colorVariable(name: variableName), "    static var exampleColor1: Color { return Color(\"ExampleColor1\") }")
        platform = .UIKit
        XCTAssertEqual(platform.colorVariable(name: variableName), "    static var exampleColor1: UIColor { return UIColor(named: \"ExampleColor1\") ?? .clear }")
    }

    static var allTests = [
        ("test_framework_outputValues", test_framework_outputValues),
        ("test_variableType_outputValues", test_variableType_outputValues),
        ("test_colorVariable_outputValues", test_colorVariable_outputValues)
    ]
}
