//
//  Santa.swift
//  SantaTracker
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import Foundation
import RealmSwift


class Santa: Object {

     private dynamic var _currentLocation: Location?
     
     var currentLocation: Location {
          
          get {
               
               // if we don't know where Santa is, he's probably still at home
               // I hear GPS isn't great up there
               
               return _currentLocation ?? Location(latitude: 90, longitude: 180)
               
          }
          
          set {
               
               _currentLocation = newValue
               
          }
          
     }
     
     override static func ignoredProperties() -> [String] {
          
          return ["currentLocation"]
          
     }
 }

 extension Santa {
     
     static func test() -> Santa {
          let santa = Santa()
          santa.currentLocation = Location(latitude: 37.7749, longitude: -122.4194)
          return santa
          
     }
     
     
     
}
