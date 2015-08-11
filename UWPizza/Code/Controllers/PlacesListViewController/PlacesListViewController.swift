//
//  PlacesListViewController.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import UIKit
import CoreLocation


class PlacesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlacesListDataProviderDelegate {
    lazy var dataProvider = PlacesListDataProvider()

    let location = CLLocation(latitude: 51.5085300, longitude: -0.1257400)

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: PlaceTableViewCell.reuseIdentifier, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: PlaceTableViewCell.reuseIdentifier)
        tableView.rowHeight = PlaceTableViewCell.height
        
        dataProvider.delegate = self
        dataProvider.fetchDataForLocation(location)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let placeDetailsViewController = segue.destinationViewController as? PlaceDetailsViewController, let place = sender as? Place {
            placeDetailsViewController.place = place
            placeDetailsViewController.location = location
        }
    }
    
    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.places.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PlaceTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! PlaceTableViewCell
        let place = dataProvider.places[indexPath.row]
        cell.configureWithPlace(place, location: location)
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
}
