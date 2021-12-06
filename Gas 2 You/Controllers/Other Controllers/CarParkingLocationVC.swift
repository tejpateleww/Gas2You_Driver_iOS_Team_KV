//
//  CarParkingLocationVC.swift
//  Gas 2 You
//
//  Created by MacMini on 03/08/21.
//

import UIKit
import GoogleMaps

class CarParkingLocationVC: BaseVC {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarTitle(isOnlyTitle: false, isMenuButton: false, title: "", controller: self)
        
        initializeTheLocationManager()
        mapView.isMyLocationEnabled = true
    }
}

extension CarParkingLocationVC: CLLocationManagerDelegate {
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var location = locationManager.location?.coordinate
        cameraMoveToLocation(toLocation: location)
        
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }
    
}
