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
        for line in linesToFilterCopy {
            if mutableRemovableLines.contains(line as! String) {
                let indexOfLineToRemove = linesToFilter.index(of: line)
                linesToFilter.removeObject(at: indexOfLineToRemove)
                
                let indexOfRemovedLine = mutableRemovableLines.firstIndex(of: line as! String)
                if indexOfRemovedLine != nil {
                    mutableRemovableLines.remove(at: indexOfRemovedLine!)
                }
            }
            if mutableRemovableLines.count == 0 {
                break;
            }
        }
    }
    
    func linesToRemove(linesToFilter:[String],removedLines:[String]) -> [String] {
        var mutableRemovedLines = removedLines
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
