//
//  SongTableViewCell.swift
//  ObligatorioFinal
//
//  Created by Invitado on 28/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class SongTableViewCell: UITableViewCell{
    
    @IBOutlet weak var songLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0.35, green: 0.35, blue: 0.28, alpha: 0.97)
        selectedBackgroundView = view
    }
}
