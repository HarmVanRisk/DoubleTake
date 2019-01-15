//
//  SourceEditorCommand.swift
//  DoubleTakeExtension
//
//  Created by mark.sharvin on 15/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        completionHandler(nil)
    }
    
    //TODO: Remove duplicate imports for Obj-C
    //TODO: Remove duplicate imports for Swift
    //TODO: Remove duplicate @class declarations
    //TOTO: Remove duplicate @protocol declarations
    
}
