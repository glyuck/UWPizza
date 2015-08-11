//
//  PlaceTableViewCell.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreLocation
import UIKit



class PlaceTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PlaceTableViewCell"
    static let height: CGFloat = 66

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    func configureWithPlace(place: Place, location: CLLocation) {
        nameLabel.text = place.name
        addressLabel.text = place.addressStreet
        let placeLocation = CLLocation(latitude: place.addressLatitude, longitude: place.addressLongitude)
        let distance = Int(round(location.distanceFromLocation(placeLocation)))
        distanceLabel.text = "\(distance) m"
    }
}
