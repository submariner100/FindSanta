//
//  FindSantaViewController.swift
//  Santa Tracker
//
//  Created by Macbook on 06/12/2016.
//  Copyright © 2016 Chappy-App. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift


class FindSantaViewController: UIViewController {


     @IBOutlet private weak var timeRemainingLabel: UILabel!
     @IBOutlet private weak var mapView: MKMapView!
     @IBOutlet private weak var activityLabel: UILabel!
     @IBOutlet private weak var temperatureLabel: UILabel!
     @IBOutlet private weak var presentsRemainingLabel: UILabel!
     
     private var mapManager: MapManager!
     


     override func viewDidLoad() {
          super.viewDidLoad()
          
          mapManager = MapManager(mapView: mapView)
          
          let realm = try! Realm()
          let santas = realm.objects(Santa.self)
          
          if santas.isEmpty {
               try? realm.write {
                    realm.add(Santa.test())
                    
               }
          }
          
          if let santa = santas.first {
               
               // update the map
               mapManager.update(with: santa)
               
          }
     }

     

}

