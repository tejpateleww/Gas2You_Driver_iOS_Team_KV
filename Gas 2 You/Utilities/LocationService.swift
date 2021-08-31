//
//  LocationService.swift


import Foundation
import CoreLocation
import UIKit

protocol LocationServiceDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    class var sharedInstance: LocationService {
        struct Static {
            static var instance = LocationService()
        }
        return Static.instance
    }

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            self.locationManager?.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            self.locationManager?.requestWhenInUseAuthorization()
            
        }else if status == .denied || status == .restricted{
            Utilities.showAlertWithTitleFromWindow(title: "", andMessage:UrlConstant.LocationRequired, buttons: [UrlConstant.Cancel, UrlConstant.Settings]) { (index) in
                if index == 1{
                    if let settingsAppURL = URL(string: UIApplication.openSettingsURLString){
                        UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        self.currentLocation = location
        Singleton.sharedInstance.userCurrentLocation = location.coordinate
        updateLocation(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error)
    }
    
    private func updateLocation(currentLocation: CLLocation){

        guard let delegate = self.delegate else {
            return
        }
        Singleton.sharedInstance.userCurrentLocation = currentLocation.coordinate
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(error: error)
    }
}
