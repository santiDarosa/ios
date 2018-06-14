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
    var minPrice: Int
    var maxPrice: Int?
    var provider: Provider
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, dateConcert: Date, minPrice: Int, maxPrice: Int?, provider: Provider) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate

        self.dateConcert = dateConcert
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.provider = provider
        
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
}
