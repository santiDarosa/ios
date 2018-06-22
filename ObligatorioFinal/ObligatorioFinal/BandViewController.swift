//
//  BandViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class BandViewController: UIViewController {
    
    var band: Band? = nil
    
    @IBOutlet weak var bandLabel: UILabel!
    @IBOutlet weak var bandImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bandLabel.text = band?.nameBand
        bandImageView.sd_setImage(with: URL(string: (band?.imageBand)!), placeholderImage: UIImage(named: (band?.nameBand)!))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
