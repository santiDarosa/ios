//
//  FinderViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class FinderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bandsTableView: UITableView!
    @IBOutlet weak var searchSwitch: UISwitch!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var bandlabel: UILabel!
    @IBOutlet weak var finderSearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var selectedBand: Band? = nil
    var bandsArray: [Band] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bandsTableView.delegate = self
        bandsTableView.dataSource = self
        bandsTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? BandViewController {
            destinationViewController.band = selectedBand
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bandsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bandsTableView.dequeueReusableCell(withIdentifier: "BandTableViewCell", for: indexPath) as! BandTableViewCell
        let band = bandsArray[indexPath.row]
        cell.bandLabel.text = band.nameBand
        cell.genderLabel.text = band.gender
        cell.bandImageView.sd_setImage(with: URL(string: band.imageBand), placeholderImage: UIImage(named: band.nameBand))
        cell.addButton.addTarget(self, action: #selector(self.addBand(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBand = bandsArray[indexPath.row]
        self.performSegue(withIdentifier: "BandViewControllerSegueIdentifier", sender: nil)
    }
    
    @objc func addBand(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: bandsTableView as UIView)
        let indexPath: IndexPath! = bandsTableView.indexPathForRow(at: point)
        let band = bandsArray[indexPath.row]
    
        if ModelManager.dictionaryFavoriteBands[band.idBand] != nil{
            let alert = UIAlertController(title: "You had selected this band already!", message: "The band is in your favourite list already", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            for concert in band.concertsBand{
                ModelManager.favoriteBands.append(band)
                ModelManager.staticBandsConcerts.append(concert)
                ModelManager.dictionaryFavoriteBands.updateValue(band, forKey: band.idBand)
            }
        
        }

    }
    
    @IBAction func switchChange(_ sender: Any) {
        if searchSwitch.isOn{
            searchLabel.text = "Search for gender"
        }else{
            searchLabel.text = "Search for name"
        }
    }
    
    @IBAction func findElements(_ sender: Any) {
        let searchText = finderSearchBar.text
        
        if (searchText?.isEmpty)!{
            let alert = UIAlertController(title: "Search bar is empty!", message: "Please, search something.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            if let searchText = searchText{
                if searchSwitch.isOn{
                    bandsArray = ModelManager.searchData(genderBand: searchText)
                } else{
                    bandsArray = ModelManager.searchData(nameBand: searchText)
                }
            }
        }
        bandsTableView.reloadData()
        if bandsArray.isEmpty{
            let alert = UIAlertController(title: "Band not found", message: "Sorry! The band not exists.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}

