//
//  ConcertViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

import SDWebImage

class ConcertViewController: UIViewController {
    
    @IBOutlet weak var concertLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var concertImageView: UIImageView!
    var concert :Concert? = nil
    var selectedBand :Band? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bandConcert = ModelManager.myBands[(concert?.bandId)!]
        selectedBand = bandConcert
        concertImageView.sd_setImage(with: URL(string: bandConcert.imageBand), placeholderImage: UIImage(named: bandConcert.nameBand))
        
        
        concertLabel.text = concert?.title
        priceLabel.text = "\(concert!.price)"
        providerLabel.text = concert?.provider.providerName
        
        let tapBandGesture = UITapGestureRecognizer(target: self, action: #selector(ConcertViewController.didSelectImage))
        concertImageView.addGestureRecognizer(tapBandGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didSelectImage() {
            self.performSegue(withIdentifier: "BandViewControllerSegueIdentifier", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BandViewController {
            destination.band = selectedBand
        }
    }
    
    
    
}
