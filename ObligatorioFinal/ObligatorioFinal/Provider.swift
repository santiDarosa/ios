//
//  Provider.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Provider{
    let providerName: String
    var providerURL: String?
    
    init(name: String, url: String) {
        self.providerName = name
        self.providerURL = url
    }
}
