//
//  Concert.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Concert{
    let placeConcert: Place
    var dateConcert: Date
    var minPrice: Int
    var maxPrice: Int?
    var provider: Provider
    
    init(placeConcert: Place, dateConcert: Date, minPrice: Int, maxPrice: Int?, provider: Provider) {
        self.placeConcert = placeConcert
        self.dateConcert = dateConcert
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.provider = provider
    }
}
