//
//  ConcertAnnotationView.swift
//  ObligatorioFinal
//
//  Created by Invitado on 3/7/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import MapKit

class ConcertAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "moreOfConcert"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            image = #imageLiteral(resourceName: "musicalNote")
        }
    }
}
