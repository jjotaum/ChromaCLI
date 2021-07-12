import XCTest
import Files
@testable import ChromaLibrary

final class FolderTests: XCTestCase {
    func testColorDefinitionsForiOS() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .iOS)
        XCTAssertEqual(definitions.count, 2)
        XCTAssertEqual(definitions.sorted().first, "    static var ExampleColor1: UIColor { return UIColor(named: \"ExampleColor1\")! }")
    }
    
    func testColorDefinitionsForMacOS() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .macOS)
        XCTAssertEqual(definitions.count, 2)
        XCTAssertEqual(definitions.sorted().first, "    static var ExampleColor1: NSColor { return NSColor(named: \"ExampleColor1\")! }")
    }
    
    func testColorDefinitionsForSwiftUI() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let definitions = folder.colorDefinitions(for: .swiftUI)
        XCTAssertEqual(definitions.count, 2)
        XCTAssertEqual(definitions.sorted().first, "    static var ExampleColor1: Color { return Color(\"ExampleColor1\") }")
    }

    static var allTests = [
        ("testColorDefinitionsForiOS", testColorDefinitionsForiOS),
        ("testColorDefinitionsForMacOS", testColorDefinitionsForMacOS),
        ("testColorDefinitionsForSwiftUI", testColorDefinitionsForSwiftUI)
    ]
}
