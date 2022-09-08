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

final class FolderTests: XCTestCase {
    private let assetPath = "/Resources/Assets.xcassets"
    private let folderAssetPath = "/Resources/FolderAssets.xcassets"
    
    func test_colorDefinitions_withRegularAsset() throws {
        let path = try XCTUnwrap(Bundle.module.resourcePath?.appending(assetPath))
        let folder = try Folder(path: path)
        var definitions = folder.fileBody(for: .iOS)
        XCTAssertEqual(definitions, expectedResult(.iOS))
        
        definitions = folder.fileBody(for: .macOS)
        XCTAssertEqual(definitions, expectedResult(.macOS))
        
        definitions = folder.fileBody(for: .swiftUI)
        XCTAssertEqual(definitions, expectedResult(.swiftUI))
    }
    
    func test_colorDefinitions_withAssetWithFolders() throws {
        let path = try XCTUnwrap(Bundle.module.resourcePath?.appending(folderAssetPath))
        let folder = try Folder(path: path)
        var definitions = folder.fileBody(for: .iOS)
        XCTAssertEqual(definitions, expectedResult(.iOS, assetType: .withFolders))
        
        definitions = folder.fileBody(for: .macOS)
        XCTAssertEqual(definitions, expectedResult(.macOS, assetType: .withFolders))
        
        definitions = folder.fileBody(for: .swiftUI)
        XCTAssertEqual(definitions, expectedResult(.swiftUI, assetType: .withFolders))
    }

    static var allTests = [
        ("test_colorDefinitions_withRegularAsset", test_colorDefinitions_withRegularAsset),
        ("test_colorDefinitions_withAssetWithFolders", test_colorDefinitions_withAssetWithFolders)
    ]
    
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
