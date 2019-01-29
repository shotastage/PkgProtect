//
//  Buttons.swift
//  Example
//
//  Created by Shota Shimazu on 2019/01/30.
//  Copyright © 2019 Shota Shimazu. All rights reserved.
//

import UIKit


class PkgProtectButton: ComponentButton {
    
    override func compose() {
        self.backgroundColor = UIColor(hex: "DA4453")
        self.layer.cornerRadius = self.frame.size.height / 2
        self.tintColor = UIColor(hex: "FFFFFF")
        self.clipsToBounds = true
        self.titleLabel!.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        
    }
}
