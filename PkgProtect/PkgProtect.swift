//
//  PkgProtect.swift
//  PkgProtect
//
//  Created by Shota Shimazu on 2019/01/29.
//  Copyright © 2019-2021 Shota Shimazu. All rights reserved.
//

import Foundation
import UIKit


open class PkgProtect {
    
    public enum Report {
        case injected
        case secured
    }

    
    public static func diagnosis(reason: Bool = false) -> (result: PkgProtect.Report, reason: String) {
        
        var defaultStatus: PkgProtect.Report = .secured
        
        var reasonString: String = ""

        // File Manager Instance
        let fileManager = FileManager.default
        
        
        let openableCheckList: [String] = [
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/LibertySB.dylib",
            "/private/var/lib/apt",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/usr/bin/ssh"
        ]
        
        let fileExistenceCheckList: [String] = [
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/usr/bin/ssh"
        ]
        
        /// Path Check
        /// --------------------------------------------------------------------------------
        for path in fileExistenceCheckList {
            if fileManager.fileExists(atPath: path) {
                reasonString = "\(path) is exists!"
                defaultStatus =  .injected
            }
        }
        
        for path in openableCheckList {
            if openable(path: path) {
                defaultStatus = .injected
            }
        }
        
        
        /// Writable Check
        /// --------------------------------------------------------------------------------
        let path = "/private/" + NSUUID().uuidString
        
        do {
            try "try.writing.private.area".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            
            reasonString = "Being writable to prohibited area!"
            defaultStatus = .injected
        } catch {
            defaultStatus = .secured
        }
        
        
        /// Simulator Check
        /// --------------------------------------------------------------------------------
        #if targetEnvironment(simulator)
        // This is a Simulator not an idevice
        defaultStatus = .secured
        #endif
               
        return (defaultStatus, reasonString)
    }
    
    
    @available(iOS, introduced: 9.0, deprecated: 13.0, renamed: "diagnosis")
    public static func invokeInjectedChecker(showReason: Bool = false) -> PkgProtect.Report {
        
        var defaultStatus: PkgProtect.Report = .secured

        
        // File Manager Instance
        let fileManager = FileManager.default
        
        
        let openableCheckList: [String] = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/LibertySB.dylib",
            "/private/var/lib/apt/",
            "/private/var/lib/apt",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/usr/bin/ssh"
        ]
        
        
        let fileExistenceCheckList: [String] = [
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/usr/bin/ssh"
        ]
        
        
        /// Path Check
        /// --------------------------------------------------------------------------------
        for path in fileExistenceCheckList {
            if fileManager.fileExists(atPath: path) {
                
                if showReason {
                    raiseAlert(reason: "\(path) is exists!")
                }
                
                defaultStatus =  .injected
            }
        }
        
        for path in openableCheckList {
            if openable(path: path) {
                defaultStatus = .injected
            }
        }
        
        
        
        /// Writable Check
        /// --------------------------------------------------------------------------------
        let path = "/private/" + NSUUID().uuidString
        
        do {
            try "try.writing.private.area".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            
            
            if showReason {
                raiseAlert(reason: "Being writable to prohibited area!")
            }

            defaultStatus = .injected
            
        } catch {
            defaultStatus = .secured
        }
        
        
        /// Simulator Check
        /// --------------------------------------------------------------------------------
        #if targetEnvironment(simulator)
        // This is a Simulator not an idevice
        defaultStatus = .secured
        #endif
        
        return defaultStatus
    }
    
    
    
    static func openable(path: String) -> Bool {
        let file = fopen(path, "r")
        
        guard file != nil else { return false }
        fclose(file)
        
        return true
    }
    
    
    static func raiseAlert(reason: String) {
        let alert: UIAlertController = UIAlertController(title: "Your device is jailbroken!", message: reason, preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(defaultAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
