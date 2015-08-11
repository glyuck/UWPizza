//
//  PlacesListViewController.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import UIKit
import CoreLocation


class PlacesListViewController: UIViewController {
    lazy var placesService = PlacesService()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        placesService.getPlacesForLocation(CLLocation(latitude: 51.5085300, longitude: -0.1257400))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
