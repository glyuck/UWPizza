//
//  PlacesListViewController.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import UIKit
import CoreLocation


class PlacesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlacesListDataProviderDelegate, PlacesListLocationManagerDelegate {
    lazy var dataProvider = PlacesListDataProvider()
    lazy var locationManager = PlacesListLocationManager()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: PlaceTableViewCell.reuseIdentifier, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: PlaceTableViewCell.reuseIdentifier)
        tableView.rowHeight = PlaceTableViewCell.height

        locationManager.delegate = self
        locationManager.requireLocationBeforeContinue()

        dataProvider.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let placeDetailsViewController = segue.destinationViewController as? PlaceDetailsViewController, let place = sender as? Place {
            placeDetailsViewController.place = place
            placeDetailsViewController.location = locationManager.location
        }
    }
    
    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.places.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PlaceTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! PlaceTableViewCell
        let place = dataProvider.places[indexPath.row]
        cell.configureWithPlace(place, location: locationManager.location!)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("ShowPlaceDetailsViewController", sender: dataProvider.places[indexPath.row])
    }
    
    // MARK: - PlacesListDataProviderDelegate

    func placesListDataProviderDidUpdateData(dataProvider: PlacesListDataProvider) {
        tableView.reloadData()
    }

    // MARK: - PlacesListLocationManagerDelegate

    func placesListLocationManager(locationManager: PlacesListLocationManager, didUpdateToLoation location: CLLocation) {
        dataProvider.fetchDataForLocation(location)
    }
}
