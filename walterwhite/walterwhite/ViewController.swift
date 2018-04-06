//
//  ViewController.swift
//  walterwhite
//
//  Created by SP 25 on 5/4/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBAction func `switch`(_ sender: Any) {
        image.image = UIImage(named:"img-profile-2.png")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.layer.borderWidth = 2
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

