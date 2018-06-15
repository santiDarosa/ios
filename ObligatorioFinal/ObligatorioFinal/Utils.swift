//
//  Utils.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 14/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Utils {
    
    static func date(from string: String, format: String = "yyyy/MM/dd HH:mm") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: string)
        return date
    }
    
    static func string(from date: Date, format: String = "yyyy/MM/dd HH:mm") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}
