//
//  LocationManager.swift
//  IOS Map
//
//  Created by english on 2025-02-12.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // init
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init(){
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {return}
        DispatchQueue.main.async {
            self.userLocation = latestLocation.coordinate
        }
    }
}
