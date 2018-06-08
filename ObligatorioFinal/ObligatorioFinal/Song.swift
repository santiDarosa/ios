//
//  Song.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 7/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class Song{
    let songName: String
    var songURL: String
    
    init(name: String, url: String) {
        self.songName = name
        self.songURL = url
    }
}
