//
//  ChromaErrorTests.swift
//  Chroma
//
//  Created by Jota Uribe on 9/06/22.
//

import XCTest
@testable import Chroma

final class ChromaErrorTests: XCTestCase {
    let mockPath = "/path/file.ext"
    
    func test_fileCreationFailed_localizedDescription() throws {
        let error = ChromaError.fileCreationFailed(path: mockPath)
        let expectedDesc = "Could not create file at /path/file.ext"
        XCTAssertEqual(error.localizedDescription, expectedDesc)
    }
    
    func test_fileCreationFailedAtFolder_localizedDescription() throws {
        let error = ChromaError.fileCreationFailedAtFolder(path: "/path", fileName: "file.ext")
        let expectedDesc = "Could not create file 'file.ext' at /path"
        XCTAssertEqual(error.localizedDescription, expectedDesc)
    }
    
    func test_invalidPath_localizedDescription() throws {
        let error = ChromaError.invalidPath(path: mockPath)
        let expectedDesc = "Invalid path: /path/file.ext"
        XCTAssertEqual(error.localizedDescription, expectedDesc)
    }
    
    
    static var allTests = [
        ("test_fileCreationFailed_localizedDescription", test_fileCreationFailed_localizedDescription),
        ("test_fileCreationFailedAtFolder_localizedDescription", test_fileCreationFailedAtFolder_localizedDescription),
        ("test_invalidPath_localizedDescription", test_invalidPath_localizedDescription)
    ]
}
