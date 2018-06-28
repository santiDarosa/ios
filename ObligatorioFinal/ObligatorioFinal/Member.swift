//
//  Member.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Member{
    let memberName: String
    var memberPhoto: String
    var memberInstrument: String
    let idBand: Int
    
    init(idBand: Int, name: String, photo: String, instrument: String) {
        self.memberName = name
        self.memberPhoto = photo
        self.memberInstrument = instrument
        self.idBand = idBand
    }
}
