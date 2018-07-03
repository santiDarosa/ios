//
//  ConcertViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

import SDWebImage

class ConcertViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var concertLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var bandsCollectionView: UICollectionView!
    @IBOutlet weak var concertImageView: UIImageView!
    var concert :Concert? = nil
    var selectedBand :Band? = nil
    var similarBands :[Band] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bandConcert = ModelManager.dictionaryBands[(concert?.bandId)!]
        if let bandConcert = bandConcert{
            selectedBand = bandConcert
            concertImageView.sd_setImage(with: URL(string: bandConcert.imageBand), placeholderImage: UIImage(named: bandConcert.nameBand))
        }
        
        view.backgroundColor = UIColor(displayP3Red: 0.25, green: 0.25, blue: 0.18, alpha: 0.50)
        
        concertLabel.text = concert?.title
        priceLabel.text = "\(concert!.price)"
        providerLabel.text = concert?.provider.providerName
        
        let tapBandGesture = UITapGestureRecognizer(target: self, action: #selector(ConcertViewController.didSelectImage))
        concertImageView.addGestureRecognizer(tapBandGesture)
        
        findingSimilarBands()
        
        bandsCollectionView.delegate = self
        bandsCollectionView.dataSource = self
        bandsCollectionView.backgroundColor = UIColor(displayP3Red: 0.25, green: 0.25, blue: 0.18, alpha: 0.50)
        
        DispatchQueue.main.async {
            self.bandsCollectionView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func didSelectImage() {
            self.performSegue(withIdentifier: "BandViewControllerSegueIdentifier", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BandViewController {
            destination.band = selectedBand
        }
    }
    
    func findingSimilarBands(){
        var band = ModelManager.dictionaryBands[(concert?.bandId)!]
        if let band = band{
            let arrayBands = ModelManager.searchData(genderBand: band.gender)
            if let arrayBands = arrayBands{
                similarBands = arrayBands
            } else {
                similarBands = []
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (similarBands.count)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 130, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     let selectedBand = similarBands[indexPath.item]
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let bandViewController = storyboard.instantiateViewController(withIdentifier: "BandViewController") as! BandViewController
     bandViewController.band = selectedBand
        self.navigationController?.pushViewController(bandViewController, animated: true)
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bandsCollectionView.dequeueReusableCell(withReuseIdentifier: "BandCollectionViewCell", for: indexPath) as! BandCollectionViewCell
        let band = similarBands[indexPath.row]
        cell.bandImageView.sd_setImage(with: URL(string: band.imageBand), placeholderImage: UIImage(named: band.nameBand))
        cell.bandLabel.text = band.nameBand
        
        return cell
    }
    
    
    
}
