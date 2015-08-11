//
//  MappingProvider.swift
//  UWPizza
//
//  Created by Vladimir Lyukov on 11/08/15.
//  Copyright (c) 2015 upwork. All rights reserved.
//

import Foundation
import EasyMapping
import MagicalRecord


class MappingProvider {
    static var placeMapping: EKManagedObjectMapping {
        return EKManagedObjectMapping(forEntityName: "Place", withBlock: { (mapping: EKManagedObjectMapping!) in
            mapping.primaryKey = "placeId"
            mapping.mapPropertiesFromDictionary([
                "id": "placeId",
                "name": "name",
                "addressStreet": "location.address",
                ])
        })
    }

    class func saveToPersistantStorageObjectsArray(JSONArray: [[String: AnyObject]], withMapping mapping: EKManagedObjectMapping) -> [AnyObject]! {
        let context = NSManagedObjectContext.MR_context()
        return EKManagedObjectMapper.arrayOfObjectsFromExternalRepresentation(
            JSONArray,
            withMapping: mapping,
            inManagedObjectContext: context)

    }
}
//[categories: (
//    {
//        icon =         {
//            prefix = "https://ss3.4sqi.net/img/categories_v2/food/pizza_";
//            suffix = ".png";
//        };
//        id = 4bf58dd8d48988d1ca941735;
//        name = "Pizza Place";
//        pluralName = "Pizza Places";
//        primary = 1;
//        shortName = Pizza;
//    }
//    ), hereNow: {
//        count = 0;
//        groups =     (
//        );
//        summary = "Nobody here";
//    }, stats: {
//        checkinsCount = 1086;
//        tipCount = 17;
//        usersCount = 877;
//    }, storeId: 228, specials: {
//        count = 0;
//        items =     (
//        );
//    }, id: 4bc6005242419521ca66031d, referralId: v-1439281248, verified: 1, location: {
//        address = "56/59 Strand";
//        cc = GB;
//        city = London;
//        country = "United Kingdom";
//        distance = 203;
//        formattedAddress =     (
//            "56/59 Strand",
//            London,
//            "Greater London",
//            "WC2N 5LR",
//            "United Kingdom"
//        );
//        lat = "51.50954376090435";
//        lng = "-0.123295783996582";
//        postalCode = "WC2N 5LR";
//        state = "Greater London";
//    }, name: Pizza Hut]