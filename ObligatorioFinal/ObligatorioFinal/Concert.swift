//
//  Concert.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import MapKit

class Concert:NSObject,MKAnnotation{
    
    var dateConcert: Date
    var price: Int
    var provider: Provider
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, dateConcert: Date, price: Int, provider: Provider) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate

        self.dateConcert = dateConcert
        self.price = price
        self.provider = provider
        
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
}
