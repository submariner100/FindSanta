//
//  Stop.swift
//  FindSanta
//
//  Created by Macbook on 12/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift


class Stop: Object {
     
     dynamic var location: Location?
     dynamic var time: Date = Date(timeIntervalSinceReferenceDate: 0)
     
     convenience init(location: Location, time: Date) {
     
          self.init()
          self.location = location
          self.time = time
          
     }
}
