//
//  FileTests.swift
//  Chroma
//
//  Created by Jota Uribe on 9/06/22.
//

import XCTest
import Files
@testable import Chroma

final class FileTests: XCTestCase {
    
    func test_init_withNameAndFolder() throws {
        let path = Bundle.module.bundlePath
        let folder = try Folder(path: path)
        let fileName = "File"
        let file = try File(named: fileName, at: folder)
        XCTAssertEqual(file.path, "\(path)/\(fileName)")
    }
    
    static var allTests = [
        ("test_init_withNameAndFolder", test_init_withNameAndFolder)
    ]
}
