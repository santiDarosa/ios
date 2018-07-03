//
//  FinderViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import Microfutures

class FinderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bandsTableView: UITableView!
    @IBOutlet weak var searchSwitch: UISwitch!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var bandlabel: UILabel!
    @IBOutlet weak var finderSearchBar: UISearchBar!
    
    var selectedBand: Band? = nil
    var bandsArray: [Band] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 0.25, green: 0.25, blue: 0.18, alpha: 0.50)
        
        finderSearchBar.tintColor = .green
        finderSearchBar.barTintColor = .green
        bandsTableView.backgroundColor = UIColor(displayP3Red: 0.25, green: 0.25, blue: 0.18, alpha: 0.50)
        bandsTableView.separatorStyle = .none

        bandsTableView.delegate = self
        bandsTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        cell.backgroundColor = UIColor(displayP3Red: 0.25, green: 0.25, blue: 0.18, alpha: 0.50)
        if ModelManager.dictionaryFavoriteBands[band.idBand] != nil{
            cell.addButton.setBackgroundImage( #imageLiteral(resourceName: "starIsMyFavorite"), for: .normal)
        } else {
            cell.addButton.setBackgroundImage( #imageLiteral(resourceName: "starNotMyFavoriteYet"), for: .normal)
        }
        
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
            ModelManager.deleteFavoriteBand(band: band)
            sender.setBackgroundImage(#imageLiteral(resourceName: "starNotMyFavoriteYet"), for: .normal)
        }
        else{
            ModelManager.addFavoriteBand(band: band)
            sender.setBackgroundImage(#imageLiteral(resourceName: "starIsMyFavorite"), for: .normal)
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
                    let myBands = ModelManager.searchData(genderBand: searchText)
                    if let myBands = myBands{
                        bandsArray = myBands
                    } else {
                        bandsArray = []
                    }
                } else{
                    let myBands = ModelManager.searchData(nameBand: searchText)
                    bandsArray = myBands
                }
            }
        }
        DispatchQueue.main.async {
            self.bandsTableView.reloadData()
        }
        
        if bandsArray.isEmpty{
            let alert = UIAlertController(title: "Band not found", message: "Sorry! The band not exists.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    


}
