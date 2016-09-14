//
//  InputViewABC.swift
//  HaidoraNibDesignable
//
//  Created by Dailingchi on 16/9/14.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import HaidoraNibDesignable

@IBDesignable
class InputViewABC: UIView,HaidoraNibDesignable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}
