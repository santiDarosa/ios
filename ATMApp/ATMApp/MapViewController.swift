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
import ObjectMapper


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
        Alamofire.request("http://ucu-atm.herokuapp.com/api/atm").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                let datos = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? String
                let atm = Mapper<ATM>().map(JSONString: datos)

                ModelManager.shared.atmLocations.append(atm)
                }
            }
        }
    }
    


