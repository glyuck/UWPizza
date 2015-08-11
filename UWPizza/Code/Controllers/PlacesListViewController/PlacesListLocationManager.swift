//
//  PlacesListLocationManager.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreLocation
import UIKit


protocol PlacesListLocationManagerDelegate: class {
    func placesListLocationManager(locationManager:PlacesListLocationManager, didUpdateToLoation location: CLLocation)
}


class PlacesListLocationManager: NSObject, CLLocationManagerDelegate {
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    weak var delegate: PlacesListLocationManagerDelegate?
    var distanceThrottleInMeters:CLLocationDistance = 5000
    private(set) var location: CLLocation?

    func requireLocationBeforeContinue() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .Denied, .Restricted:
            let alert = UIAlertController(title: "Location disabled", message: "Please enable location usage in settings", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Settings", style: .Default, handler: { (action: UIAlertAction!) in
                UIApplication.sharedApplication().openURL(NSURL(string:UIApplicationOpenSettingsURLString)!)
            }))
        default:
            locationManager(locationManager, didChangeAuthorizationStatus: status)
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let newLocation = locations.last as? CLLocation {
            if location == nil || location!.distanceFromLocation(newLocation) >= distanceThrottleInMeters {
//                println("Location: \(location), newLocation: \(newLocation), distance: \(location?.distanceFromLocation(newLocation))")
                location = newLocation
                delegate?.placesListLocationManager(self, didUpdateToLoation: newLocation)
            }
        }
    }
}
