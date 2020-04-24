//
//  MapViewController.swift
//  spotter
//
//  Created by Mark Anthony Molina on 24/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import Foundation
import GoogleMaps

class MapViewController: BelowMenuContentViewController {
    
    private let delegate: MapViewDelegate = MapViewDelegate()
    private let myLocationButton = MyLocationButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layout()
    }
    
    private func setupViews() {
        let mapView = GMSMapView(frame: view.frame)
        mapView.delegate = delegate
        mapView.isMyLocationEnabled = true
        view.addSubview(mapView)
        
        view.addSubview(myLocationButton)
    }
    
    private func layout() {
        let constraints = [
            myLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension MapViewController {
    
    private func zoomToUserLocation(mapView: GMSMapView) {
        
        guard let userLocation = mapView.myLocation else { return }
        let camera = GMSCameraUpdate.setTarget(CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude), zoom: 14.0)
        mapView.moveCamera(camera)
        
    }
}
