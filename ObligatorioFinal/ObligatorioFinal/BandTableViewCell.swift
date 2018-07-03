//
//  BandTableViewCell.swift
//  ObligatorioFinal
//
//  Created by Invitado on 28/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class BandTableViewCell: UITableViewCell{
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bandImageView: UIImageView!
    @IBOutlet weak var bandLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0.35, green: 0.35, blue: 0.28, alpha: 0.97)
        selectedBackgroundView = view
    }
    

}
