//
//  ComponentView.swift
//  Example
//
//  Created by Shota Shimazu on 2019/01/30.
//  Copyright © 2019 Shota Shimazu. All rights reserved.
//

import UIKit


@IBDesignable
class ComponentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        compose()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        composeLayout()
    }
    
    func compose() { }
    
    func composeStyle() { }
    
    func composeLayout() { }
}



class ComponentButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        compose()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        compose()
    }
    
    
    override func draw(_ rect: CGRect) {
        compose()
    }
    
    func compose() { }
}

