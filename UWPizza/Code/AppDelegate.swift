//
//  AppDelegate.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import UIKit
import QuadratTouch


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Setup foursquare credentials
        let client = Client(clientID: "P05EANSHEAOJLAQYMBV3LMST1RILC2SJ52UEKISSLKHCL40V",
            clientSecret:   "N1YCDBOA2NONUKUDLPKIJWU0KRSHKPCP1NOD41RGIXZVVJU0",
            redirectURL:    "uwpizza://foursquare")
        var configuration = Configuration(client:client)
        configuration.mode = "foursquare"
        configuration.shouldControllNetworkActivityIndicator = true
        Session.setupSharedSessionWithConfiguration(configuration)

        return true
    }
}
