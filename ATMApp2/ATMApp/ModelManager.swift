//
//  ModelManager.swift
//  ATMApp
//
//  Created by SP 25 on 18/5/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class ModelManager{
    
    static var atmLocations = [] as [ATM]
    static let shared = ModelManager()
    init(){
    }
    
    static func getService(){
        let URL = "http://ucu-atm.herokuapp.com/api/atm"
        Alamofire.request(URL).responseArray { (response: DataResponse<[ATM]>) in
            let atmArray = response.result.value
            atmLocations = atmArray!
            
        }
        
    }
    
}
