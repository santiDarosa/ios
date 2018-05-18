//
//  ATM.swift
//  ATMApp
//
//  Created by SP 25 on 17/5/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
enum Network {
    case "Banred"
    case "RedBrou"
}
enum Status {
    case "normal"
    case "normal (with tint)"
    case "out of order"
}
class ATM{
    var acceptsDeposits: Bool
    var address: String
    var hasMoney: Bool
    var id: Int
    var imageUrl: String
    var latitude: Float
    var longitude: Float
    var network: Network
    var openHours: (Int,Int)
    var status: Status
    init(){}
    
}
