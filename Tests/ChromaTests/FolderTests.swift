import XCTest
import Files
@testable import ChromaLibrary

final class FolderTests: XCTestCase {
    func testColorDefinitionsForiOS() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .iOS)
        let expectedResults = ["    static var exampleColor1: UIColor { return UIColor(named: \"Example Color 1\")! }",
                               "    static var exampleColor2: UIColor { return UIColor(named: \"exampleColor2\")! }",
                               "    static var exampleColor3: UIColor { return UIColor(named: \"ExampleColor3\")! }",
                               "    static var exampleColor4: UIColor { return UIColor(named: \"ExampleColor4-\")! }"]
        XCTAssertEqual(definitions.sorted(), expectedResults)
    }
    
    func testColorDefinitionsForMacOS() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .macOS)
        let expectedResults = ["    static var exampleColor1: NSColor { return NSColor(named: \"Example Color 1\")! }",
                               "    static var exampleColor2: NSColor { return NSColor(named: \"exampleColor2\")! }",
                               "    static var exampleColor3: NSColor { return NSColor(named: \"ExampleColor3\")! }",
                               "    static var exampleColor4: NSColor { return NSColor(named: \"ExampleColor4-\")! }"]
        XCTAssertEqual(definitions.sorted(), expectedResults)
    }
    
    func testColorDefinitionsForSwiftUI() throws {
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
        ("testColorDefinitionsForiOS", testColorDefinitionsForiOS),
        ("testColorDefinitionsForMacOS", testColorDefinitionsForMacOS),
        ("testColorDefinitionsForSwiftUI", testColorDefinitionsForSwiftUI)
    ]
}
