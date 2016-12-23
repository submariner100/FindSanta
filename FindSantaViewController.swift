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


class FindSantaViewController: UIViewController, MKMapViewDelegate {

     


     @IBOutlet private weak var timeRemainingLabel: UILabel!
     @IBOutlet private weak var mapView: MKMapView!
     @IBOutlet private weak var activityLabel: UILabel!
     @IBOutlet private weak var temperatureLabel: UILabel!
     @IBOutlet private weak var presentsRemainingLabel: UILabel!
     
     private var mapManager: MapManager!
     
     private let realmManager = SantaRealmManager()
     
     private var notificationToken: NotificationToken?
     
     private var santa: Santa?
     
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
          
          // Set up the map manager
          mapManager = MapManager(mapView: mapView)
          
          
                    
          
          // Find the Santa data in Realm
          
          realmManager.logIn {
               
               if let realm = self.realmManager.realm() {
                    let santas = realm.objects(Santa.self)
                    
                   // Has Santa's info already been downloaded?
                   
               if let santa = santas.first {
                    //Yep,  so just use it
                    self.santa = santa
                    santa.addObserver(self)
                 
               } else {
                    
               self.notificationToken = santas.addNotificationBlock {
                    
                    _ in
                    let santas = realm.objects(Santa.self)
                    if let santa = santas.first {
                         self.notificationToken?.stop()
                         self.notificationToken = nil
                         self.santa = santa
                         santa.addObserver(self)
                         }
                    }
               }
          }
     }
}

     deinit {
          santa?.removeObserver(self)
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

     
     
//     deinit {
//          let realm = realmManager.realm()
//          let santas = realm.objects(Santa.self)
//          if let santa = santas.first {
//               santa.removeObserver(self)
//          }
//     }
}



