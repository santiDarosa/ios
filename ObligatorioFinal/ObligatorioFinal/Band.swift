//
//  Band.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Band{
    
    var idBand: Int
    var nameBand: String
    var concertsBand: [Concert] = []
    var membersBand: [Member] = []
    var songsBand: [Song] = []
    var imageBand: String
    var gender: String
    
    init(id: Int, name: String, image: String, gender: String) {
        self.idBand = id
        self.nameBand = name
        self.imageBand = image
        self.gender = gender
    }
    
    func addConcert(concert: Concert){
        self.concertsBand.append(concert)
    }
    
    func addMember(member: Member){
        self.membersBand.append(member)
    }
    
    func addSong(song: Song){
        self.songsBand.append(song)
    }
}
