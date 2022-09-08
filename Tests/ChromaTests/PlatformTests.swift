//
//  FileTests.swift
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

final class PlatformTests: XCTestCase {
    private let assetPath = "/Resources/Assets.xcassets"
    private let folderAssetPath = "/Resources/FolderAssets.xcassets"
    
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
    
    func test_fileBodyFormat_withRegularAsset() throws {
        let path = try XCTUnwrap(Bundle.module.resourcePath?.appending(assetPath))
        let assetPath = try Folder(path: path)
        var fileBody = Platform.iOS.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.iOS))
        
        fileBody = Platform.macOS.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.macOS))
        
        fileBody = Platform.swiftUI.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.swiftUI))
    }
    
    func test_fileBodyFormat_withAssetWithFolders() throws {
        let path = try XCTUnwrap(Bundle.module.resourcePath?.appending(folderAssetPath))
        let assetPath = try Folder(path: path)
        var fileBody = Platform.iOS.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.iOS, assetType: .withFolders))
        
        fileBody = Platform.macOS.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.macOS, assetType: .withFolders))
        
        fileBody = Platform.swiftUI.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.swiftUI, assetType: .withFolders))
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

extension PlatformTests {
    private func expectedResult(_ platform: Platform, assetType: AssetType = .regular) -> [String] {
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
