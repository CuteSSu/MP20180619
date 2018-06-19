//
//  StoreViewController.swift
//  Bcosmetic
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import MapKit
class StoreViewController: UIViewController {
    @IBOutlet var map: MKMapView!
    
    var selectedIndex: Int? = nil
    
    var store: Store? = nil
    
    var storeAnnotation: Store? = nil
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 가장 최근의 위치 값
        let location: CLLocation = locations[locations.count-1]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = selectedIndex {
            map.setRegion(MKCoordinateRegionMake((self.store?.coordinate)!, MKCoordinateSpanMake(0.007, 0.007)), animated: true)
        }
        
        // 기존의 맵에 annotation이 있었다면 삭제
        if let annotation = storeAnnotation {
            self.map.removeAnnotation(annotation)
        }
        // 새로운 annotation 위치가 있다면 추가
        if let annotation = store {
            self.storeAnnotation = annotation
            self.map.addAnnotation(self.storeAnnotation!)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStoreView" {
            if let destVC = segue.destination as? StoreTableViewController {
                destVC.mainVC = self
            } }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
