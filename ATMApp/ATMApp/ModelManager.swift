//
//  ModelManager.swift
//  ATMApp
//
//  Created by SP 25 on 18/5/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
class ModelManager{
    
    public var atmLocations: [ATM]
    static let shared = ModelManager()
    init(){
        atmLocations = []
    }
    
}
