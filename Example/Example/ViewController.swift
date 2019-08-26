//
//  ViewController.swift
//  Example
//
//  Created by Shota Shimazu on 2019/01/30.
//  Copyright © 2019 Shota Shimazu. All rights reserved.
//

import UIKit
import PkgProtect


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkJailbroken(_ sender: Any) {
        
        if PkgProtect.actualStatus == PkgProtect.Report.secured {
            let alert: UIAlertController = UIAlertController(title: "Your device is safe!",     message: "PkgProtect report your device havn't been jailbroken.", preferredStyle:  UIAlertController.Style.alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            
            alert.addAction(defaultAction)
            
            present(alert, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "Your device is Hacked!", message: "PkgProtect report your device has been jailbroken!", preferredStyle:  UIAlertController.Style.alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            
            alert.addAction(defaultAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    

    @IBAction func exitApp(_ sender: Any) {
        exit(0)
    }
}

