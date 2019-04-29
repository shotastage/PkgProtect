//
//  PkgProtect.swift
//  PkgProtect
//
//  Created by Shota Shimazu on 2019/01/29.
//  Copyright © 2019 Shota Shimazu. All rights reserved.
//

import Foundation
import UIKit


open class PkgProtect {
    
    public enum Report {
        case injected
        case secured
    }



    #if DEBUG
    
    public static var status: PkgProtect.Report {
        get {
            return .secured
        }
    }
    
    public static var actualStatus: PkgProtect.Report {
        get {
            return invokeInjectedChecker(showReason: true)
        }
    }
    
    #else
    
    public static var status: PkgProtect.Report {
        get {
            return invokeInjectedChecker()
        }
    }

    #endif
    
    
    
    static func invokeInjectedChecker(showReason: Bool = false) -> PkgProtect.Report {
        
        // File Manager Instance
        let fileManager = FileManager.default
        
        
        let checkPaths: [String] = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/LibertySB.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/usr/bin/ssh",
            "/private/var/lib/apt"
        ]
        
        
        
        /// Simulator Check
        /// --------------------------------------------------------------------------------
        #if arch(i386) || arch(x86_64)
        // This is a Simulator not an idevice
        return .secured
        #endif
        
        
        /// URL Scheme Check
        /// --------------------------------------------------------------------------------
        guard let cydiaUrlScheme = URL(string: "cydia://package/com.example.package") else {
            return .secured
        }

        if UIApplication.shared.canOpenURL(cydiaUrlScheme as URL) {
            
            if showReason {
                raiseAlert(reason: "Cydia URL scheme is openable!")
            }
            
            return .injected
        }
        
        
        /// Path Check
        /// --------------------------------------------------------------------------------
        for path in checkPaths {
            if fileManager.fileExists(atPath: path) {
                
                if showReason {
                    raiseAlert(reason: "\(path) is exists!")
                }
                
                return .injected
            }
            
            if openable(path: path) {
                
                if showReason {
                    raiseAlert(reason: "\(path) is exists!")
                }
                
                return .injected
            }
        }
        
       
        
        
        /// Writable Check
        /// --------------------------------------------------------------------------------
        let path = "/private/" + NSUUID().uuidString
        
        do {
            try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            
            
            if showReason {
                raiseAlert(reason: "Being writable to prohibited area!")
            }

            return .injected
            
        } catch {
            return .secured
        }
        
    }
    
    
    static func openable(path: String) -> Bool {
        let file = fopen(path, "r")
        
        guard file != nil else { return false }
        fclose(file)
        
        return true
    }
    
    
    static func raiseAlert(reason: String) {
        let alert: UIAlertController = UIAlertController(title: "Your device is jailbroken!",     message: reason, preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(defaultAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
