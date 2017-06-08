//
//  ASPNETDateMapper.swift
//  SelfTaping
//
//  Created by Eugene Yagrushkin on 2017-06-06.
//  Copyright © 2017 Casting Workbook Services Inc. All rights reserved.
//

import Foundation
import ObjectMapper

open class ASPNETDateTransform: DateFormatterTransform {
    
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
        
        super.init(dateFormatter: formatter)
    }
    
}
