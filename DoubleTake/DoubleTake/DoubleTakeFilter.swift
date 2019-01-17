//
//  DoubleTakeFilter.swift
//  DoubleTake
//
//  Created by mark.sharvin on 16/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import Cocoa

class DoubleTakeFilter: NSObject {

    func filterLines(linesToFilter:NSMutableArray, removableLines:NSMutableArray) {
        let linesToFilterCopy = linesToFilter
        let mutableRemovableLines = removableLines
        for index in (0...linesToFilterCopy.count-1).reversed() {
            let line = linesToFilterCopy[index] as! String
            if mutableRemovableLines.contains(line) {
                let numberOfIndexes = linesToFilter.count-1
                let reversedArray = linesToFilter.reversed() as! [String]
                let indexOfLineToRemoveFromReversedOrder = reversedArray.index(of: line)
                linesToFilter.removeObject(at: numberOfIndexes-indexOfLineToRemoveFromReversedOrder!)
                
                let indexOfRemovedLine = mutableRemovableLines.index(of: line)
                if indexOfRemovedLine != NSNotFound {
                    mutableRemovableLines.removeObject(at: indexOfRemovedLine)
                }
            }
            if mutableRemovableLines.count == 0 {
                break;
            }
        }
    }
    
    func duplicateLines(linesToFilter:NSMutableArray,duplicateLines:NSMutableArray) -> NSMutableArray {
        let mutableRemovedLines = duplicateLines
        var foundLines = [String]()
        for line in linesToFilter {
            if foundLines.contains(line as! String) {
                mutableRemovedLines.add(line)
            } else {
                foundLines.append(line as! String)
            }
        }
        return NSMutableArray(array: mutableRemovedLines)
    }
    
    func findLinesFromRegex(lines:NSMutableArray, regex:String) -> NSMutableArray {
        let objCImports = lines.filter { (line) -> Bool in
            return containsString(string: line as! String,regexPattern:regex)
        }
        return NSMutableArray(array:objCImports);
    }
    
    func containsString(string:String ,regexPattern:String) -> Bool {
        let regex = try! NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
        let range = NSRange(0 ..< string.count)
        let result = regex.firstMatch(in: string, options: .reportProgress, range: range) != nil
        return result
    }
    
}
