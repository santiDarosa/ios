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
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


//ObjectMapper

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    @IBOutlet weak var ATMMapView: MKMapView!
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelManager.getService()
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
        let locValue:CLLocationCoordinate2D = locations.first!.coordinate
        //let location = locations.last as CLLocation
        
        ATMMapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: locValue, span: span)
        ATMMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are here"
        annotation.subtitle = "current location"
        ATMMapView.addAnnotation(annotation)
        
        for atm in ModelManager.atmLocations{
            print(atm)
            let annotationATM = MKPointAnnotation()
            annotationATM.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(atm.latitude!), CLLocationDegrees(atm.longitude!))
            annotationATM.title = atm.network?.uppercased()
            annotationATM.subtitle = atm.address
            
            ATMMapView.addAnnotation(annotationATM)
        }
        
        //centerMap(locValue)
    }
    
    }
    


