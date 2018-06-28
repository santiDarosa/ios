//
//  BandViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class BandViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    var band: Band? = nil
    var selectedBand :Band? = nil
    var similarBands :[Band] = []
    
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var bandsCollectionView: UICollectionView!
    @IBOutlet weak var membersCollectionView: UICollectionView!
    @IBOutlet weak var bandLabel: UILabel!
    @IBOutlet weak var bandImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bandLabel.text = band?.nameBand
        bandImageView.sd_setImage(with: URL(string: (band?.imageBand)!), placeholderImage: UIImage(named: (band?.nameBand)!))
        
        membersCollectionView.delegate = self
        membersCollectionView.dataSource = self
        membersCollectionView.reloadData()
        
        findingSimilarBands()
        
        bandsCollectionView.delegate = self
        bandsCollectionView.dataSource = self
        bandsCollectionView.reloadData()
        
        songsTableView.delegate = self
        songsTableView.dataSource = self
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
    
    func findingSimilarBands(){
        for band in ModelManager.myBands{
            if band.gender == self.band!.gender && band.idBand != self.band?.idBand{
                self.similarBands.append(band)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == membersCollectionView{
            return (self.band?.membersBand.count)!
        }else{
            return similarBands.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == membersCollectionView{
            return CGSize(width: 160, height: 160)
        } else {
            return CGSize(width: 120, height: 120)
        }
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
        if collectionView == bandsCollectionView {
            let selectedBand = similarBands[indexPath.item]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let bandViewController = storyboard.instantiateViewController(withIdentifier: "BandViewController") as! BandViewController
            bandViewController.band = selectedBand
                self.navigationController?.pushViewController(bandViewController, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == membersCollectionView{
            let cell = membersCollectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
            let member = band?.membersBand[indexPath.row]
            if let member = member {
                cell.memberImageView.sd_setImage(with: URL(string: member.memberPhoto), placeholderImage: UIImage(named: member.memberName))
                cell.memberNameLabel.text = member.memberName
                cell.memberInstrumentLabel.text = member.memberInstrument
            }
            return cell
        } else{
            let cell = bandsCollectionView.dequeueReusableCell(withReuseIdentifier: "BandCollectionViewCell", for: indexPath) as! BandCollectionViewCell
            let band = similarBands[indexPath.row]
            cell.bandImageView.sd_setImage(with: URL(string: band.imageBand), placeholderImage: UIImage(named: band.nameBand))
            cell.bandLabel.text = band.nameBand
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (band?.songsBand.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songsTableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        let song = band?.songsBand[indexPath.row]
        cell.songLabel.text = song?.songName
        
        return cell
    }
}
