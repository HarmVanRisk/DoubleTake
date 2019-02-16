//
//  ViewController.swift
//  DoubleTake
//
//  Created by mark.sharvin on 15/01/2019.
//  Copyright © 2019 Mark Sharvin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var helpMessageLabel: NSScrollView!
    @IBOutlet weak var thankYouMessageContainer: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thankYou = thankYouMessage()
        thankYouMessageContainer.documentView!.insertText(thankYou)
        let help = helpMessage()
        helpMessageLabel.documentView!.insertText(help)
        
    }
    
    func thankYouMessage() -> NSAttributedString {
        let thankYouMessage = NSMutableAttributedString(string: "Thank you for using this extension.\n\nIf you like what you see let me know on ")
        let twitterAttributes = [NSAttributedString.Key.link:NSURL(string: "https://twitter.com/ArcherSharvin")!] as [NSAttributedString.Key : Any]
        let twitterLink = NSAttributedString(string: "twitter", attributes:twitterAttributes)
        let gitMessage = NSAttributedString(string: " or star my Repo on Git ")
        let gitAttributes = [NSAttributedString.Key.link:NSURL(string: "https://github.com/HarmVanRisk/DoubleTake")!] as [NSAttributedString.Key : Any]
        let gitLink = NSAttributedString(string: "here", attributes:gitAttributes)
        let finish = NSAttributedString(string: ".")
        
        thankYouMessage.append(twitterLink)
        thankYouMessage.append(gitMessage)
        thankYouMessage.append(gitLink)
        thankYouMessage.append(finish)
        
        thankYouMessage.addAttribute(NSAttributedString.Key.font, value: NSFont(name: "Arial", size: 16)!, range: NSMakeRange(0, thankYouMessage.length))
        
        return thankYouMessage
    }

    func helpMessage() -> NSAttributedString {
        let helpMessage = NSMutableAttributedString(string: "Requirements:\n\tDoubleTake requires XCode 8 or later.\n\nHow to use DoubleTake?\n\t- Open a project in XCode\n\t- Open a file that contains an amount of imports, class or protocol delcarations\n\t- Highlight the declarations\n\t- In the XCode menu choose:\n\tEditor -> DoubleTake -> Remove Duplicates\n\nTips:\n\t- Create a shortcut for the extension by going to\n\tXCode -> Preferences -> Key Bindings\n\tfilter the menu by DoubleTake. There you can set\n\tyour own shortcut.")
        helpMessage.addAttribute(NSAttributedString.Key.font, value: NSFont(name: "Arial", size: 15)!, range: NSMakeRange(0, helpMessage.length))
        helpMessage.addAttribute(NSAttributedString.Key.font, value: NSFont(name: "Arial Rounded MT Bold", size: 17)!, range: helpMessage.mutableString.range(of: "Requirements:"))
        helpMessage.addAttribute(NSAttributedString.Key.font, value: NSFont(name: "Arial Rounded MT Bold", size: 17)!, range: helpMessage.mutableString.range(of: "How to use DoubleTake?"))
        helpMessage.addAttribute(NSAttributedString.Key.font, value: NSFont(name: "Arial Rounded MT Bold", size: 17)!, range: helpMessage.mutableString.range(of: "Tips:"))
        
        return helpMessage;
    }

}

