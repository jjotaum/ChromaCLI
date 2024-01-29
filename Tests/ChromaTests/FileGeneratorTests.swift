//
//  FileGeneratorTests.swift
//  Chroma
//
//  Created by Jota Uribe on 16/10/23.
//

import XCTest
import Files
@testable import Chroma

final class FileGeneratorTests: XCTestCase {
    func test_headerFormat_withExtensionOutputFile() throws {
        var sut = FileGenerator(
            asset: "asset.xcasset",
            path: "file.swift",
            type: .extension,
            framework: .AppKit
        )
        XCTAssertEqual(sut.header(fileName: "Asset"), "extension NSColor")
        
        
        sut = FileGenerator(
            asset: "asset.xcasset",
            path: "file.swift",
            type: .extension,
            framework: .SwiftUI
        )
        XCTAssertEqual(sut.header(fileName: "Asset"), "extension Color")
        
        
        sut = FileGenerator(
            asset: "asset.xcasset",
            path: "file.swift",
            type: .extension,
            framework: .UIKit
        )
        XCTAssertEqual(sut.header(fileName: "Asset"), "extension UIColor")
    }
    
    func test_headerFormat_withStructOutputFile() throws {
        var sut = FileGenerator(
            asset: "asset.xcasset",
            path: "file.swift",
            type: .struct,
            framework: .AppKit
        )
        XCTAssertEqual(sut.header(fileName: "asset"), "struct Asset")
        
        
        sut = FileGenerator(
            asset: "asset.xcasset",
            path: "file.swift",
            type: .struct,
            framework: .SwiftUI
        )
        XCTAssertEqual(sut.header(fileName: "asset"), "struct Asset")
        
        
        sut = FileGenerator(
            asset: "asset.xcasset",
            path: "file.swift",
            type: .struct,
            framework: .UIKit
        )
        XCTAssertEqual(sut.header(fileName: "asset"), "struct Asset")
    }
        
    func test_fileBodyFormat_withRegularAsset() throws {
        let path = try XCTUnwrap(resourceFilePath(fileName: "Assets.xcassets"))
        let assetPath = try Folder(path: path)
        var sut = FileGenerator(
            asset: path,
            path: "file.swift",
            type: .extension,
            framework: .AppKit
        )
        var fileBody = sut.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.AppKit))
        
        sut = FileGenerator(
            asset: path,
            path: "file.swift",
            type: .extension,
            framework: .SwiftUI
        )
        fileBody = sut.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.SwiftUI))
        
        sut = FileGenerator(
            asset: path,
            path: "file.swift",
            type: .extension,
            framework: .UIKit
        )
        fileBody = sut.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.UIKit))
    }
    
    func test_fileBodyFormat_withAssetWithFolders() throws {
        let path = try XCTUnwrap(resourceFilePath(fileName: "FolderAssets.xcassets"))
        let assetPath = try Folder(path: path)
        var sut = FileGenerator(
            asset: path,
            path: "file.swift",
            type: .extension,
            framework: .AppKit
        )
        var fileBody = sut.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.AppKit, assetType: .withFolders))
        
        sut = FileGenerator(
            asset: path,
            path: "file.swift",
            type: .extension,
            framework: .SwiftUI
        )
        fileBody = sut.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.SwiftUI, assetType: .withFolders))
        
        sut = FileGenerator(
            asset: path,
            path: "file.swift",
            type: .extension,
            framework: .UIKit
        )
        fileBody = sut.fileBody(asset: assetPath)
        XCTAssertEqual(fileBody, expectedResult(.UIKit, assetType: .withFolders))
    }
    
    static var allTests = [
        ("test_headerFormat_withExtensionOutputFile", test_headerFormat_withExtensionOutputFile),
        ("test_headerFormat_withStructOutputFile", test_headerFormat_withStructOutputFile),
        ("test_fileBodyFormat_withRegularAsset", test_fileBodyFormat_withRegularAsset),
        ("test_fileBodyFormat_withAssetWithFolders", test_fileBodyFormat_withAssetWithFolders)
    ]
}

// MARK: - Helper Methods

extension FileGeneratorTests {
    private enum AssetType {
        case regular
        case withFolders
    }
    
    private func resourceFilePath(fileName: String) throws -> String {
        let resourcePath = try XCTUnwrap(Bundle.module.resourcePath)
        do {
            _ = try Folder(path: resourcePath.appending("/Resources"))
            return resourcePath.appending("/Resources/\(fileName)")
        } catch {
            return resourcePath.appending("/\(fileName)")
        }
    }
    
    private func expectedResult(_ framework: Framework, assetType: AssetType = .regular) -> [String] {
        let variableType = framework.variableType
        let defaultValue = framework.defaultValue
        switch assetType {
        case .regular:
            return [
                "    static var exampleColor1: \(variableType) { return \(variableType)(\(framework.parameterName)\"Example Color 1\") \(defaultValue)}",
                "    static var exampleColor2: \(variableType) { return \(variableType)(\(framework.parameterName)\"exampleColor2\") \(defaultValue)}",
                "    static var exampleColor3: \(variableType) { return \(variableType)(\(framework.parameterName)\"ExampleColor3\") \(defaultValue)}",
                "    static var exampleColor4: \(variableType) { return \(variableType)(\(framework.parameterName)\"ExampleColor4-\") \(defaultValue)}"
            ]
        case .withFolders:
            return [
                "    static var rootExampleColor: \(variableType) { return \(variableType)(\(framework.parameterName)\"Root Example Color\") \(defaultValue)}",
                "    // MARK: - Example 1",
                "    static var exampleColor1: \(variableType) { return \(variableType)(\(framework.parameterName)\"Example Color 1\") \(defaultValue)}",
                "    static var exampleColor2: \(variableType) { return \(variableType)(\(framework.parameterName)\"exampleColor2\") \(defaultValue)}",
                "    static var exampleColor3: \(variableType) { return \(variableType)(\(framework.parameterName)\"ExampleColor3\") \(defaultValue)}",
                "    static var exampleColor4: \(variableType) { return \(variableType)(\(framework.parameterName)\"ExampleColor4-\") \(defaultValue)}",
                "    // MARK: - SubFolder",
                "    static var subFolderExampleColor: \(variableType) { return \(variableType)(\(framework.parameterName)\"SubFolder Example Color\") \(defaultValue)}"
            ]
        }
    }
}
