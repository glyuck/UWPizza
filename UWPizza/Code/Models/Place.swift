//
//  Place.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreData
import CoreLocation
import Foundation


@objc(Place)
class Place: NSManagedObject {
    @NSManaged var placeId: String!
    @NSManaged var name: String!
    @NSManaged var addressStreet: String!
    @NSManaged var addressLatitude: Double
    @NSManaged var addressLongitude: Double

    func distanceStringFromLocation(location: CLLocation) -> String {
        let selfLocation = CLLocation(latitude: addressLatitude, longitude: addressLongitude)
        let distance = location.distanceFromLocation(selfLocation)
        if distance > 1000 {
            return String(format: "%.01f km", distance/1000)
        } else {
            return String(format: "%.f m", distance)
        }
    }
}
