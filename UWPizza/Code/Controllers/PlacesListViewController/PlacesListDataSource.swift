//
//  PlacesListDataSource.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreData
import Foundation
import CoreLocation
import MagicalRecord


protocol PlacesListDataProviderDelegate: class {
    func placesListDataProviderDidUpdateData(dataProvider: PlacesListDataProvider)
}


class PlacesListDataProvider: NSObject {
    private lazy var placesService = PlacesService()
    private var location: CLLocation?

    weak var delegate: PlacesListDataProviderDelegate?
    private(set) var places = [Place]()

    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "placesUpdatedNotification:", name: PlacesService.Notifications.DidUpdatePlaces, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func fetchDataForLocation(location: CLLocation) {
        self.location = location
        placesService.getPlacesForLocation(location)
        loadDataFromCoreData()
    }

    func placesUpdatedNotification(notification: NSNotification) {
        loadDataFromCoreData()
    }

    func loadDataFromCoreData() {
        if let location = location {
            let allPlaces = Place.MR_findAll() as! [Place]
            let nearPlaces = allPlaces.sorted { return $0.location.distanceFromLocation(location) < $1.location.distanceFromLocation(location) }
            places = Array(allPlaces[0..<min(allPlaces.count, PlacesService.Constants.limit)]).sorted { $0.name < $1.name }
            delegate?.placesListDataProviderDidUpdateData(self)
        } else {
            places = []
        }
    }
}
