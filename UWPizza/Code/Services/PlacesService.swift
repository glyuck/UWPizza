//
//  PlacesService.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreLocation
import Foundation
import QuadratTouch


class PlacesService {
    enum Constants {
        static let limit = 5
        static let query = "pizza restaurant"
    }

    enum Notifications {
        static let DidUpdatePlaces = "PlacesServiceDidUpdatePlaces"
    }

    func getPlacesForLocation(location: CLLocation) {
        let parameters = [
            Parameter.query: Constants.query,
            Parameter.ll: locationToParam(location),
            Parameter.limit: Constants.limit.description
        ]

        let searchTask = Session.sharedSession().venues.search(parameters) { (result: QuadratTouch.Result) in
            if let response = result.response, let venues = response["venues"] as? [[String:AnyObject]] {
                MappingProvider.saveToPersistantStorageObjectsArray(venues, withMapping: MappingProvider.placeMapping)
                NSNotificationCenter.defaultCenter().postNotificationName(Notifications.DidUpdatePlaces, object: self)
            }
        }
        searchTask.start()
    }

    func locationToParam(location: CLLocation) -> String {
        return "\(location.coordinate.latitude),\(location.coordinate.longitude)"
    }
}
