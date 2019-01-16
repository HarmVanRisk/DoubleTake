//
//  DoubleTakeFilter.swift
//  DoubleTake
//
//  Created by mark.sharvin on 16/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import Cocoa

class DoubleTakeFilter: NSObject {

    func filterLines(linesToFilter:NSMutableArray, removableLines:[String]) {
        let linesToFilterCopy = linesToFilter
        var mutableRemovableLines = removableLines
        for index in (0...linesToFilterCopy.count-1).reversed() {
            let line = linesToFilterCopy[index] as! String
            if mutableRemovableLines.contains(line) {
                let numberOfIndexes = linesToFilter.count-1
                let reversedArray = linesToFilter.reversed() as! [String]
                let indexOfLineToRemoveFromReversedOrder = reversedArray.index(of: line)
                linesToFilter.removeObject(at: numberOfIndexes-indexOfLineToRemoveFromReversedOrder!)
                
                let indexOfRemovedLine = mutableRemovableLines.firstIndex(of: line)
                if indexOfRemovedLine != nil {
                    mutableRemovableLines.remove(at: indexOfRemovedLine!)
                }
            }
            if mutableRemovableLines.count == 0 {
                break;
            }
        }
    }
    
    func duplicateLines(linesToFilter:[String],duplicateLines:[String]) -> [String] {
        var mutableRemovedLines = duplicateLines
        var foundLines = [String]()
        for line in linesToFilter {
            if foundLines.contains(line) {
                mutableRemovedLines.append(line)
            } else {
                foundLines.append(line)
            }
        }
        return mutableRemovedLines
    }
    
    func objectiveCImports(lines:[String]) -> [String] {
        let objCImports = lines.filter { (line:String) -> Bool in
            return containsString(string: line,regexPattern:"#import|@import")
        }
        return objCImports;
    }
    
    func containsString(string:String ,regexPattern:String) -> Bool {
        let regex = try! NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
        let range = NSRange(0 ..< string.count)
        let result = regex.firstMatch(in: string, options: .reportProgress, range: range) != nil
        return result
    }
    
}
