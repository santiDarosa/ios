//
//  ConcertViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class ConcertViewController: UIViewController {
    
    @IBOutlet weak var concertLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var concertImageView: UIImageView!
    var concert :Concert? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        concertLabel.text = concert?.title
        priceLabel.text = concert?.price
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
