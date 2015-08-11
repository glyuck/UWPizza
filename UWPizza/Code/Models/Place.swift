//
//  Place.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreData
import Foundation


@objc(Place)
class Place: NSManagedObject {
    @NSManaged var placeId: String!
    @NSManaged var name: String!
    @NSManaged var addressStreet: String!
}
