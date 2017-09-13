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

open class ASPNETDateTransformShort: DateFormatterTransform {
    
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        super.init(dateFormatter: formatter)
    }
    
}

open class ASPNETDateTransformShort2: DateFormatterTransform {
    
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        super.init(dateFormatter: formatter)
    }
    
}

open class  ASPNETDateTransformAll: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    let formatter = DateFormatter()
    
    public init() {
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            formatter.locale = Locale(identifier: "en_US_POSIX")

            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
            if let date = formatter.date(from: dateString){
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            if let date = formatter.date(from: dateString){
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            if let date = formatter.date(from: dateString){
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = formatter.date(from: dateString){
                return date
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
