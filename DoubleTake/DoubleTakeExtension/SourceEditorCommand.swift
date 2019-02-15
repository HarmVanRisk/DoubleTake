//
//  SourceEditorCommand.swift
//  DoubleTakeExtension
//
//  Created by mark.sharvin on 15/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import Foundation
import XcodeKit

let filterRegex = "#import|@import|@class|@protocol|(?<!#|@)import"

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let linesToClean : NSMutableArray
        let selectionRange = invocation.buffer.selections.firstObject as! XCSourceTextRange
        if selectionRange.start.line == selectionRange.end.line {
            linesToClean = invocation.buffer.lines
        } else {
            let length = selectionRange.end.line+1 - selectionRange.start.line
            linesToClean = NSMutableArray(array:invocation.buffer.lines.subarray(with: NSMakeRange(selectionRange.start.line, length)))
        }
        let objCLines = DoubleTakeFilter().findLinesFromRegex(lines: linesToClean, regex: filterRegex)
        let removabelLines = DoubleTakeFilter().duplicateLines(linesToFilter: objCLines, duplicateLines: NSMutableArray())
        DoubleTakeFilter().filterLines(linesToFilter: invocation.buffer.lines, removableLines: removabelLines)
        completionHandler(nil)
    }
}
