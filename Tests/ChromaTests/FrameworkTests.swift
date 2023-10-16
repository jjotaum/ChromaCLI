//
//  FrameworkTests.swift
//  Chroma
//
//  Created by Jota Uribe on 9/06/22.
//

import XCTest
import Files
@testable import Chroma

private enum AssetType {
    case regular
    case withFolders
}

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
    
    func test_fileBodyFormat_withRegularAsset() throws {
        let path = try XCTUnwrap(resourceFilePath(fileName: "Assets.xcassets"))
        let assetPath = try Folder(path: path)
        var fileBody = Framework.AppKit.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.AppKit))
        
        fileBody = Framework.AppKit.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.AppKit))
        
        fileBody = Framework.SwiftUI.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.SwiftUI))
    }
    
    func test_fileBodyFormat_withAssetWithFolders() throws {
        let path = try XCTUnwrap(resourceFilePath(fileName: "FolderAssets.xcassets"))
        let assetPath = try Folder(path: path)
        var fileBody = Framework.AppKit.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.AppKit, assetType: .withFolders))
        
        fileBody = Framework.AppKit.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.AppKit, assetType: .withFolders))
        
        fileBody = Framework.SwiftUI.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.SwiftUI, assetType: .withFolders))
    }

    static var allTests = [
        ("test_framework_outputValues", test_framework_outputValues),
        ("test_variableType_outputValues", test_variableType_outputValues),
        ("test_colorVariable_outputValues", test_colorVariable_outputValues),
        ("test_fileBodyFormat_withRegularAsset", test_fileBodyFormat_withRegularAsset),
        ("test_fileBodyFormat_withAssetWithFolders", test_fileBodyFormat_withAssetWithFolders)
    ]
}

// MARK: - Helper Methods

extension FrameworkTests {
    private func resourceFilePath(fileName: String) throws -> String {
        let resourcePath = try XCTUnwrap(Bundle.module.resourcePath)
        do {
            _ = try Folder(path: resourcePath.appending("/Resources"))
            return resourcePath.appending("/Resources/\(fileName)")
        } catch {
            return resourcePath.appending("/\(fileName)")
        }
    }
    
    private func expectedResult(_ platform: Framework, assetType: AssetType = .regular) -> [String] {
        let variableType = platform.variableType
        let defaultValue = platform.defaultValue
        switch assetType {
        case .regular:
            return [
                "    static var exampleColor1: \(variableType) { return \(variableType)(\(platform.parameterName)\"Example Color 1\") \(defaultValue)}",
                "    static var exampleColor2: \(variableType) { return \(variableType)(\(platform.parameterName)\"exampleColor2\") \(defaultValue)}",
                "    static var exampleColor3: \(variableType) { return \(variableType)(\(platform.parameterName)\"ExampleColor3\") \(defaultValue)}",
                "    static var exampleColor4: \(variableType) { return \(variableType)(\(platform.parameterName)\"ExampleColor4-\") \(defaultValue)}"
            ]
        case .withFolders:
            return [
                "    static var rootExampleColor: \(variableType) { return \(variableType)(\(platform.parameterName)\"Root Example Color\") \(defaultValue)}",
                "    // MARK: - Example 1",
                "    static var exampleColor1: \(variableType) { return \(variableType)(\(platform.parameterName)\"Example Color 1\") \(defaultValue)}",
                "    static var exampleColor2: \(variableType) { return \(variableType)(\(platform.parameterName)\"exampleColor2\") \(defaultValue)}",
                "    static var exampleColor3: \(variableType) { return \(variableType)(\(platform.parameterName)\"ExampleColor3\") \(defaultValue)}",
                "    static var exampleColor4: \(variableType) { return \(variableType)(\(platform.parameterName)\"ExampleColor4-\") \(defaultValue)}",
                "    // MARK: - SubFolder",
                "    static var subFolderExampleColor: \(variableType) { return \(variableType)(\(platform.parameterName)\"SubFolder Example Color\") \(defaultValue)}"
            ]
        }
    }
}
