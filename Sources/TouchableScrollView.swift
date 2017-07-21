//
//  File.swift
//  SelfTaping
//
//  Created by Evgeny Yagrushkin on 2017-07-20.
//  Copyright © 2017 Casting Workbook Services Inc. All rights reserved.
//

import Foundation

class TouchableScrollView: UIScrollView{
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl{
            return false
        }
        return true
    }
    
}
