//
//  FileTests.swift
//  XcodeServerSDK
//
//  Created by Mateusz Zając on 22/07/15.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import XCTest
@testable import XcodeServerSDK

class FileTests: XCTestCase {
    
    let sampleAdded: NSDictionary = [
        "status": 1,
        "filePath": "File1.swift"
    ]
    
    let sampleOther: NSDictionary = [
        "status": 1024,
        "filePath": "File2.swift"
    ]
    
    // MARK: Initialization
    func testDictionaryInit() throws {
        var file = try File(json: sampleAdded as NSDictionary)
        
        XCTAssertEqual(file.filePath, "File1.swift")
        XCTAssertEqual(file.status, FileStatus.added)
        
        file = try File(json: sampleOther)
        
        XCTAssertEqual(file.filePath, "File2.swift")
        XCTAssertEqual(file.status, FileStatus.other)
    }
    
    func testInit() {
        let file = File(filePath: "File1.swift", status: .added)

        XCTAssertEqual(file.filePath, "File1.swift")
        XCTAssertEqual(file.status, FileStatus.added)
    }
    
    // MARK: Dictioninarifying
    func testDictionarify() throws {
        let file = try File(json: sampleAdded as NSDictionary)
        
        XCTAssertEqual(file.dictionarify(), sampleAdded)
    }
    
}
