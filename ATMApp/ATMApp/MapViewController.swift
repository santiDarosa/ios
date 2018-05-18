//
//  MapViewController.swift
//  ATMApp
//
//  Created by SP 25 on 17/5/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import RestEssentials

//ObjectMapper

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    @IBOutlet weak var ATMMapView: MKMapView!
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getService()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        ATMMapView.delegate = self
        ATMMapView.mapType = .standard
        ATMMapView.isZoomEnabled = true
        ATMMapView.isScrollEnabled = true
        if let coor = ATMMapView.userLocation.location?.coordinate{
            ATMMapView.setCenter(coor, animated: true)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = locations.last!.coordinate
        //let location = locations.last as CLLocation
        
        ATMMapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: locValue, span: span)
        ATMMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Javed Multani"
        annotation.subtitle = "current location"
        ATMMapView.addAnnotation(annotation)
        
        //centerMap(locValue)
    }
    func getService(){
        guard let rest = RestController.make(urlString: "http://ucu-atm.herokuapp.com/api/atm") else {
            print("Bad URL")
            return
        }
        
        rest.get(withDeserializer: JSONDeserializer()) { result, httpResponse in
            do {
                let json = try result.value()
                print(json.array)
            } catch {
                print("Error performing GET: \(error)")
            }
        }
    }
    
}

