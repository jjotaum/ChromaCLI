//
//  FileTests.swift
//  Chroma
//
//  Created by Jota Uribe on 9/06/22.
//

import XCTest
import Files
@testable import Chroma

final class FolderTests: XCTestCase {
    func test_iOS_colorDefinitions_shouldReturnUIColorList() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .iOS)
        let expectedResults = ["    static var exampleColor1: UIColor { return UIColor(named: \"Example Color 1\") ?? .clear }",
                               "    static var exampleColor2: UIColor { return UIColor(named: \"exampleColor2\") ?? .clear }",
                               "    static var exampleColor3: UIColor { return UIColor(named: \"ExampleColor3\") ?? .clear }",
                               "    static var exampleColor4: UIColor { return UIColor(named: \"ExampleColor4-\") ?? .clear }"]
        XCTAssertEqual(definitions.sorted(), expectedResults)
    }
    
    func test_macOS_colorDefinitions_shouldReturnNSColorList() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .macOS)
        let expectedResults = ["    static var exampleColor1: NSColor { return NSColor(named: \"Example Color 1\") ?? .clear }",
                               "    static var exampleColor2: NSColor { return NSColor(named: \"exampleColor2\") ?? .clear }",
                               "    static var exampleColor3: NSColor { return NSColor(named: \"ExampleColor3\") ?? .clear }",
                               "    static var exampleColor4: NSColor { return NSColor(named: \"ExampleColor4-\") ?? .clear }"]
        XCTAssertEqual(definitions.sorted(), expectedResults)
    }
    
    func test_swiftUI_colorDefinitions_shouldReturnColorList() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .swiftUI)
        let expectedResults = ["    static var exampleColor1: Color { return Color(\"Example Color 1\") }",
                               "    static var exampleColor2: Color { return Color(\"exampleColor2\") }",
                               "    static var exampleColor3: Color { return Color(\"ExampleColor3\") }",
                               "    static var exampleColor4: Color { return Color(\"ExampleColor4-\") }"]
        XCTAssertEqual(definitions.sorted(), expectedResults)
    }

    static var allTests = [
        ("test_iOS_colorDefinitions_shouldReturnUIColorList", test_iOS_colorDefinitions_shouldReturnUIColorList),
        ("test_macOS_colorDefinitions_shouldReturnNSColorList", test_macOS_colorDefinitions_shouldReturnNSColorList),
        ("test_swiftUI_colorDefinitions_shouldReturnColorList", test_swiftUI_colorDefinitions_shouldReturnColorList)
    ]
}
