//
//  CollectionController.swift
//  tablas
//
//  Created by SP 25 on 12/4/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}
