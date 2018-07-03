//
//  MemberCollectionViewCell.swift
//  ObligatorioFinal
//
//  Created by Invitado on 28/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class MemberCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var memberInstrumentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        memberImageView.layer.borderWidth = 1.0
        memberImageView.layer.borderColor = UIColor.black.cgColor
        memberImageView.layer.cornerRadius = 10.0
        memberImageView.layer.masksToBounds = false
        memberImageView.clipsToBounds = true
    }
    
    
}
