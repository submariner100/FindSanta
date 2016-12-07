//
//  MapManager.swift
//  SantaTracker
//
//  Created by Macbook on 07/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift



class MapManager: NSObject {
     
     private var santaAnnotation = MKPointAnnotation()
     
     init(mapView: MKMapView) {
          
          santaAnnotation.title = "🎅"
          super.init()
          mapView.addAnnotation(self.santaAnnotation)
          
     }
     
     func update(with santa: Santa) {
     
          let santaLocation = santa.currentLocation.clLocationCoordinate2D
          DispatchQueue.main.async {
               self.santaAnnotation.coordinate = santaLocation
          }
          
          // update the map to show Santa's new location
     }
     
}

private extension Location {
     
     var clLocationCoordinate2D: CLLocationCoordinate2D {
          return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
          
          
     }
}

