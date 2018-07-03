//
//  MapViewController.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 13/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var concertsMapView: MKMapView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var priceSwitch: UISwitch!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var goToFinderButton: UIButton!
    
    var selectedConcert: Concert?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelManager.searchData()
        concertsMapView.delegate = self
        filterView.backgroundColor = UIColor(displayP3Red: 0.15, green: 0.15, blue: 0.08, alpha: 0.90)
        filterView.layer.borderColor = UIColor.black.cgColor
        filterView.layer.borderWidth = 5.0
        
        concertsMapView.register(ConcertAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        goToFinderButton.backgroundColor = UIColor(displayP3Red: 0.15, green: 0.15, blue: 0.08, alpha: 0.90)
        goToFinderButton.layer.borderColor = UIColor.black.cgColor
        goToFinderButton.layer.borderWidth = 3.0
        goToFinderButton.layer.cornerRadius = goToFinderButton.frame.size.height / 2
        goToFinderButton.clipsToBounds = true
        
        priceSwitch.thumbTintColor = UIColor(displayP3Red: 0.55, green: 0.55, blue: 0.48, alpha: 0.90)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        concertsMapView.removeAnnotations(concertsMapView.annotations)
        let concerts = self.loadConcerts(price: 5000)
        if concerts.isEmpty{
            let alert = UIAlertController(title: "No concerts to display!", message: "Sorry! Try to add new bands!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Concert else { return nil }
        let identifier = "MKMapViewDefaultAnnotationViewReuseIdentifier"
        var view: ConcertAnnotationView
        
        if let dequeuedView = concertsMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? ConcertAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = ConcertAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        selectedConcert = view.annotation as! Concert?
        self.performSegue(withIdentifier: "ConcertViewControllerSegueIdentifier", sender: nil)
        
    }
    
    func loadConcerts(price: Int) -> [Concert]{
        var concertsToDisplay : [Concert] = []
        for concertList in ModelManager.staticBandsConcerts.values {
            for concert in concertList{
                if concert.price < price{
                    concertsToDisplay.append(concert)
                }
            }
        }
        concertsMapView.addAnnotations(concertsToDisplay)
        return concertsToDisplay
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ConcertViewController {
            destinationViewController.concert = selectedConcert
        }
    }
    
    @IBAction func filterViewButton(_ sender: Any) {
        filterView.isHidden = true
        if priceSwitch.isOn{
            let price = Int(priceSlider.value)
            concertsMapView.removeAnnotations(concertsMapView.annotations)
            let concerts = loadConcerts(price: price)
            if concerts.isEmpty{
                let alert = UIAlertController(title: "No concerts to display!", message: "Sorry! Try to add new bands!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func filterButton(_ sender: Any) {
        priceSlider.setThumbImage(#imageLiteral(resourceName: "dollars"), for: .normal)
        priceSlider.isEnabled = false
        priceSwitch.isOn = false
        valueLabel.isHidden = true
        filterView.isHidden = false
        priceSlider.minimumValue = 0
        priceSlider.maximumValue = 5000
        
    }
    @IBAction func addBandButton(_ sender: Any) {
        self.performSegue(withIdentifier: "FinderViewControllerSegueIdentifier", sender: nil)
    }
    @IBAction func activatePriceSwitch(_ sender: Any) {
        priceSlider.isEnabled = priceSwitch.isOn
        valueLabel.isHidden = !priceSwitch.isOn
        valueLabel.text = "\(Int(priceSlider.value))"
    }
    
    @IBAction func changeValuePriceSlider(_ sender: Any) {
        valueLabel.text = "\(Int(priceSlider.value))"
    }
}
