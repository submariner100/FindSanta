//
//  Location.swift
//  SantaTracker
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit


class Location: Object {
     
     dynamic var latitude: Double = 0.0
     dynamic var longitude: Double = 0.0
     
     convenience init(latitude: Double, longitude: Double) {
          
          self.init()
          self.latitude = latitude
          self.longitude = longitude
     }
     
}

