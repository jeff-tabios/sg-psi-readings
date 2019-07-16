//
//  MapViewCOntroller.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 16/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, SettingsProtocol{
    
    @IBOutlet weak var mapView: MKMapView!
    var annotations:[MKPointAnnotation?] = []
    var params:[String:String] = [:]
    let vm = PSIReadingViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshReadings()
    }
    
    func refreshReadings(){
        vm.requestReading(params:self.params){
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            if self.vm.reading != nil {
                self.annotations = self.vm.createAnnotations()
                self.annotations.forEach{
                    if let a=$0{
                        self.mapView.addAnnotation(a)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                    })
                }
            }
        }
    }
    
    func refreshFromSettings(date: String) {
        if date.count == 10{
            params = ["date":date]
        }else{
            params = ["date_time":date]
        }
        print(params)
        refreshReadings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
    }
}



