//
//  SourceEditorCommandTests.swift
//  DoubleTakeTests
//
//  Created by mark.sharvin on 16/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import XCTest

class DoubleTakeFilterTests: XCTestCase {
    var filter : DoubleTakeFilter!
    override func setUp() {
        filter = DoubleTakeFilter()
    }

    override func tearDown() {
        filter = nil
    }
    
    func testFilterLines() {
        let allLines = NSMutableArray(array: ["#import \"file1.h\"\n\r",
                                              "#import \"file2.h\"\n\r",
                                              "#import \"file3.h\"\n\r",
                                              "#import \"file4.h\"\n\r",
                                              "#import \"file5.h\"\n\r",
                                              "#import \"file5.h\"\n\r",
                                              "#import \"file6.h\"\n\r",
                                              "#import \"file7.h\"\n\r",
                                              "#import \"file4.h\"\n\r",
                                              "#import \"file8.h\"\n\r",
                                              "#import \"file9.h\"\n\r",
                                              "#import \"file10.h\"\n\r",
                                              "#import \"file9.h\"\n\r",
                                              "#import \"file11.h\"\n\r",
                                              "#import \"file9.h\"\n\r",
                                              "#import \"file2.h\"\n\r",
                                              "@interface SomeViewController ()"])
        let removableLines = NSMutableArray(array: ["#import \"file5.h\"\n\r",
                            "#import \"file4.h\"\n\r",
                            "#import \"file2.h\"\n\r",
                            "#import \"file9.h\"\n\r",
                            "#import \"file9.h\"\n\r"])
        filter.filterLines(linesToFilter: allLines , removableLines: removableLines)
        let expectedLines = NSMutableArray(array: ["#import \"file1.h\"\n\r",
                        "#import \"file2.h\"\n\r",
                        "#import \"file3.h\"\n\r",
                        "#import \"file4.h\"\n\r",
                        "#import \"file5.h\"\n\r",
                        "#import \"file6.h\"\n\r",
                        "#import \"file7.h\"\n\r",
                        "#import \"file8.h\"\n\r",
                        "#import \"file9.h\"\n\r",
                        "#import \"file10.h\"\n\r",
                        "#import \"file11.h\"\n\r",
                        "@interface SomeViewController ()"])
        XCTAssertTrue(allLines.isEqual(to: expectedLines))
    }
    
    func testLinesToRemove() {
        let allLines = NSMutableArray(array:["#import \"file1.h\"\n\r",
                        "#import \"file2.h\"\n\r",
                        "#import \"file3.h\"\n\r",
                        "#import \"file4.h\"\n\r",
                        "#import \"file5.h\"\n\r",
                        "#import \"file5.h\"\n\r",
                        "#import \"file6.h\"\n\r",
                        "#import \"file7.h\"\n\r",
                        "#import \"file4.h\"\n\r",
                        "#import \"file8.h\"\n\r",
                        "#import \"file9.h\"\n\r",
                        "#import \"file10.h\"\n\r",
                        "#import \"file11.h\"\n\r",
                        "#import \"file2.h\"\n\r",
                        "@interface SomeViewController ()"])
        let expectedDuplicateLines = NSMutableArray(array:["#import \"file5.h\"\n\r",
                                 "#import \"file4.h\"\n\r",
                                 "#import \"file2.h\"\n\r"])
        let duplicates = filter.duplicateLines(linesToFilter: allLines, duplicateLines: NSMutableArray())
        XCTAssertTrue(duplicates.isEqual(to: expectedDuplicateLines))
    }
    
    func testObjectiveCImports() {
        let allLines = NSMutableArray(array: ["#import \"file1.h\"\n\r",
                     "#import \"file2.h\"\n\r",
                     "#import \"file3.h\"\n\r",
                     "#import \"file4.h\"\n\r",
                     "#import \"file5.h\"\n\r",
                     "#import \"file5.h\"\n\r",
                     "#import \"file6.h\"\n\r",
                     "#import \"file7.h\"\n\r",
                     "@implementation SomeViewController",
                     "#import \"file8.h\"\n\r",
                     "@property (weak, nonatomic) IBOutlet UITableView *someTableView;",
                     "#import \"file6.h\"\n\r",
                     "static double const someConst = 0.35;",
                     "#import \"file2.h\"\n\r",
                     "@interface SomeViewController ()"])
        let expectedObjCLines = ["#import \"file1.h\"\n\r",
                                 "#import \"file2.h\"\n\r",
                                 "#import \"file3.h\"\n\r",
                                 "#import \"file4.h\"\n\r",
                                 "#import \"file5.h\"\n\r",
                                 "#import \"file5.h\"\n\r",
                                 "#import \"file6.h\"\n\r",
                                 "#import \"file7.h\"\n\r",
                                 "#import \"file8.h\"\n\r",
                                 "#import \"file6.h\"\n\r",
                                 "#import \"file2.h\"\n\r"]
        let objcImports = filter.findLinesFromRegex(lines: allLines, regex: "#import|@import")
        XCTAssertTrue(objcImports.isEqual(to: expectedObjCLines))
    }
    
    func testSwiftImports() {
        let allLines = NSMutableArray(array: ["import \"file1.h\"\n\r",
                                              "import \"file2.h\"\n\r",
                                              "import \"file3.h\"\n\r",
                                              "import \"file4.h\"\n\r",
                                              "import \"file5.h\"\n\r",
                                              "import \"file5.h\"\n\r",
                                              "#import \"file6.h\"\n\r",
                                              "import \"file7.h\"\n\r",
                                              "@implementation SomeViewController",
                                              "import \"file8.h\"\n\r",
                                              "@property (weak, nonatomic) IBOutlet UITableView *someTableView;",
                                              "#import \"file6.h\"\n\r",
                                              "static double const someConst = 0.35;",
                                              "import \"file2.h\"\n\r",
                                              "@interface SomeViewController ()"])
        let expectedSwiftLines = ["import \"file1.h\"\n\r",
                                 "import \"file2.h\"\n\r",
                                 "import \"file3.h\"\n\r",
                                 "import \"file4.h\"\n\r",
                                 "import \"file5.h\"\n\r",
                                 "import \"file5.h\"\n\r",
                                 "import \"file7.h\"\n\r",
                                 "import \"file8.h\"\n\r",
                                 "import \"file2.h\"\n\r"]
        let objcImports = filter.findLinesFromRegex(lines: allLines, regex: "(?<!#|@)import")
        XCTAssertTrue(objcImports.isEqual(to: expectedSwiftLines))
    }
    
    func testContainsStringForRegex() {
        let objcImportPattern = "#import|@import"
        XCTAssertTrue(filter.containsString(string: "#import \"1234.h\"", regexPattern: objcImportPattern))
        XCTAssertTrue(filter.containsString(string: "@import Something", regexPattern: objcImportPattern))
        XCTAssertFalse(filter.containsString(string: "import Something", regexPattern: objcImportPattern))
        XCTAssertFalse(filter.containsString(string: "Do we even know what we want to import", regexPattern: objcImportPattern))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
