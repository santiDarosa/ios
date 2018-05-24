//
//  ATM.swift
//  ATMApp
//
//  Created by SP 25 on 17/5/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import ObjectMapper


class ATM: Mappable{
    var acceptsDeposits: Bool?
    var address: String?
    var hasMoney: Bool?
    var id: Int?
    var imageUrl: String?
    var latitude: Float?
    var longitude: Float?
    var network: String?
    var openHours: String?
    var status: String?
        required init?(map: Map){
        
        }
    func mapping(map: Map){
        acceptsDeposits <- map["accepts_deposits"]
        address <- map["address"]
        hasMoney <- map["has_money"]
        id <- map["id"]
        imageUrl <- map["image_url"]
        latitude <- map["location.lat"]
        longitude <- map["location.lon"]
        network <- map["network"]
        openHours <- map["open_hours"]
        status <- map["status"]
    }
    
}
