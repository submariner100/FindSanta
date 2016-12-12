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
               
               santa.addObserver(self)
          }
     }
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
          if let santa = object as? Santa {
               update(with: santa)
               
          } else {
               super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
          }
     }

     private func update(with santa: Santa) {
          mapManager.update(with: santa)
          let activity = santa.activity.description
          let presentsRemaining = "\(santa.presentsRemaining)"
          DispatchQueue.main.async {
               self.activityLabel.text = activity
               self.presentsRemainingLabel.text = presentsRemaining
          }
     }

     
     
     deinit {
          let realm = try! Realm()
          let santas = realm.objects(Santa.self)
          if let santa = santas.first {
               santa.removeObserver(self)
          }
     }
}



