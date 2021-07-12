import XCTest
import Files
@testable import ChromaLibrary

final class PlatformTests: XCTestCase {
    func testColorVariableForiOS() throws {
        let variable = Platform.iOS.colorVariable(name: "ExampleColor1")
        XCTAssertEqual(variable, "    static var ExampleColor1: UIColor { return UIColor(named: \"ExampleColor1\")! }")
    }
    
    func testColorVariableForMacOS() throws {
        let variable = Platform.macOS.colorVariable(name: "ExampleColor1")
        XCTAssertEqual(variable, "    static var ExampleColor1: NSColor { return NSColor(named: \"ExampleColor1\")! }")
    }
    
    func testColorVariableForSwiftUI() throws {
        let variable = Platform.swiftUI.colorVariable(name: "ExampleColor1")
        XCTAssertEqual(variable, "    static var ExampleColor1: Color { return Color(\"ExampleColor1\") }")
    }

    static var allTests = [
        ("testColorVariableForiOS", testColorVariableForiOS),
        ("testColorVariableForMacOS", testColorVariableForMacOS),
        ("testColorVariableForSwiftUI", testColorVariableForSwiftUI)
    ]
}
