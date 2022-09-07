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
    func test_framework_outputValues() {
        XCTAssertEqual(Platform.iOS.framework, "UIKit")
        XCTAssertEqual(Platform.macOS.framework, "AppKit")
        XCTAssertEqual(Platform.swiftUI.framework, "SwiftUI")
    }
    
    func test_variableType_outputValues() {
        XCTAssertEqual(Platform.iOS.variableType, "UIColor")
        XCTAssertEqual(Platform.macOS.variableType, "NSColor")
        XCTAssertEqual(Platform.swiftUI.variableType, "Color")
    }
    
    func test_colorVariable_outputValues() throws {
        let variableName = "ExampleColor1"
        var platform: Platform = .iOS
        XCTAssertEqual(platform.colorVariable(name: variableName), "    static var exampleColor1: UIColor { return UIColor(named: \"ExampleColor1\") ?? .clear }")
        platform = .macOS
        XCTAssertEqual(platform.colorVariable(name: variableName), "    static var exampleColor1: NSColor { return NSColor(named: \"ExampleColor1\") ?? .clear }")
        platform = .swiftUI
        XCTAssertEqual(platform.colorVariable(name: variableName), "    static var exampleColor1: Color { return Color(\"ExampleColor1\") }")
    }

    static var allTests = [
        ("test_framework_outputValues", test_framework_outputValues),
        ("test_variableType_outputValues", test_variableType_outputValues),
        ("test_colorVariable_outputValues", test_colorVariable_outputValues)
    ]
}
