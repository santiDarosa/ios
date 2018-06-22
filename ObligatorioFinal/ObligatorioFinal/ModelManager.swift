//
//  ModelManager.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 14/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import MapKit
class ModelManager{
    public static var myBands:[Band] = []
    public static var myBandsConcerts:[Concert] = []
    
    public static func addData(){
        let greenDay = Band(id: 1,name: "Green Day", image: "https://www.imer.mx/reactor/wp-content/uploads/sites/40/green-day-cr-frank-maddocks-2017-billboard-1548-1548x774.jpg", gender: "Punk Rock")
        let gdArg = Concert(title: "Green Day in Argentina", locationName: "Jose Amalfitani Stadium", coordinate: CLLocationCoordinate2D(latitude: 21.283957, longitude: -157.831611), dateConcert: Utils.date(from: "2018/11/10 21:00")!, price: 800, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: myBands.count)
        
        let gdBr = Concert(title: "Green Day in Brazil", locationName: "Beira Rio Stadium", coordinate: CLLocationCoordinate2D(latitude: 21.27339, longitude: -157.823802), dateConcert: Utils.date(from: "2018/11/13 21:00")!, price: 500, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: myBands.count)
        let gdCol = Concert(title: "Green Day in Colombia", locationName: "Cafetal Stadium", coordinate: CLLocationCoordinate2D(latitude: 21.270449, longitude: -157.819816), dateConcert: Utils.date(from: "2018/11/16 21:00")!, price: 1000, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: myBands.count)
        greenDay.addConcert(concert: gdArg)
        greenDay.addConcert(concert: gdBr)
        greenDay.addConcert(concert: gdCol)
        
        myBands.append(greenDay)
        for conc in greenDay.concertsBand {
            myBandsConcerts.append(conc)
        }
    }
    
}
