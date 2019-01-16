//
//  SourceEditorCommandTests.swift
//  DoubleTakeTests
//
//  Created by mark.sharvin on 16/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import XCTest

class DoubleTakeFilterTests: XCTestCase {
//    var editorCommand : SourceEditorCommand!
    override func setUp() {
//        editorCommand = SourceEditorCommand()
    }

    override func tearDown() {
//        editorCommand = nil
    }

    
    func testContainsStringForRegex() {
        let filter:DoubleTakeFilter = DoubleTakeFilter()
        let objcImportPattern = "#import|@import"
        XCTAssertTrue(filter.containsString(string: "#import \"1234.h\"", regexPattern: objcImportPattern))
        XCTAssertTrue(filter.containsString(string: "@import Something", regexPattern: objcImportPattern))
        XCTAssertFalse(filter.containsString(string: "import Something", regexPattern: objcImportPattern))
        XCTAssertFalse(filter.containsString(string: "Do we even know what we want to import", regexPattern: objcImportPattern))
    }
    
    func testObjectiveCImports() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
