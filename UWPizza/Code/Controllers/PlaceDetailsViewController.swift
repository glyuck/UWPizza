//
//  PlaceDetailsViewController.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import CoreLocation
import UIKit


class PlaceDetailsViewController: UIViewController {
    var location: CLLocation!
    var place: Place!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "Name: \(place.name)"
        let address = place.addressStreet ?? "unspecified"
        addressLabel.text = "Address: \(address)"
        distanceLabel.text = "Distance: \(place.distanceStringFromLocation(location))"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
