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
    
    @IBOutlet weak var concertsMapView: MKMapView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var priceSwitch: UISwitch!
    @IBOutlet weak var priceSlider: UISlider!
    
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var locationSlider: UISlider!
    var selectedConcert: Concert?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        // Do any additional setup after loading the view, typically from a nib.
        // show concert on map
        concertsMapView.delegate = self
        ModelManager.addData()
        var concertsToDisplay : [Concert] = []
        for concert in ModelManager.myBandsConcerts {
            if concert.price < 1200{
                concertsToDisplay.append(concert)
            }
        }
        concertsMapView.addAnnotations(concertsToDisplay)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        concertsMapView.setRegion(coordinateRegion, animated: true)
    }
    
    //show the annotations (esto usar para ver los conciertos de las bandas)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Concert else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = concertsMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    //al apretar el boton de la marker deberia hacer un segue y mostrar los detalles del concierto
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        selectedConcert = view.annotation as! Concert
        self.performSegue(withIdentifier: "ConcertViewControllerSegueIdentifier", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ConcertViewController {
            destinationViewController.concert = selectedConcert
        }
    }
    
    //esto es para pedirle al user su ubicacion
    /*
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            concertsMapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    */
    
    @IBAction func filterViewButton(_ sender: Any) {
        filterView.isHidden = true
    }
    @IBAction func filterButton(_ sender: Any) {
        filterView.isHidden = false
    }
    @IBAction func addBandButton(_ sender: Any) {
        self.performSegue(withIdentifier: "FinderViewControllerSegueIdentifier", sender: nil)
    }
    @IBAction func activatePriceSwitch(_ sender: Any) {
        priceSlider.isEnabled = priceSwitch.isOn
    }
    @IBAction func activateLocationSwitch(_ sender: Any) {
        locationSlider.isEnabled = locationSwitch.isOn
    }
    
}
