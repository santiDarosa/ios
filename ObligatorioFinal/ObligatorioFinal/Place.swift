//
//  Place.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Place{
    let country: String
    let city: String
    let latitude: Double
    let longitude: Double
    
    init(country: String, city: String, latitude: Double, longitude: Double) {
        self.country = country
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
}
