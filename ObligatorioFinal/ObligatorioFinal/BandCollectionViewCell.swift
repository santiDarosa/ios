//
//  BandCollectionViewCell.swift
//  ObligatorioFinal
//
//  Created by Invitado on 28/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class BandCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var bandImageView: UIImageView!
    
    @IBOutlet weak var bandLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bandImageView.layer.borderWidth = 1.0
        bandImageView.layer.borderColor = UIColor.black.cgColor
        bandImageView.layer.cornerRadius = 10.0
        bandImageView.layer.masksToBounds = false
        bandImageView.clipsToBounds = true
    }
}
