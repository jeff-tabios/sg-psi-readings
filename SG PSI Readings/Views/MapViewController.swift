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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    var annotations:[MKPointAnnotation?] = []
    var params:[String:String] = [:]
    let vm = PSIReadingViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshReadings()
        addDateViewShadow()
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
                        self.showDate(date: self.params.map{$0.value}.joined(separator: ""))
                    })
                }
            }else{
                self.showWarning()
                self.dateLabel.text = "Something happened..."
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
    
    func showWarning(){
        let dialogMessage = UIAlertController(title: "Connection Problem", message: "Cannot connect to server. Please check your connection and refresh.", preferredStyle: .alert)
        
        let refresh = UIAlertAction(title: "Refresh", style: .default, handler: { (action) -> Void in
            self.refreshReadings()
        })
        
        dialogMessage.addAction(refresh)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func showDate(date: String){
        var displayDate = date
        if displayDate.isEmpty {
            displayDate = Date().toStr()
        }
        dateLabel.text = displayDate
    }
    
    func addDateViewShadow(){
        dateView.layer.cornerRadius = 4
        dateView.layer.shadowColor = UIColor.black.cgColor
        dateView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        dateView.layer.shadowOpacity = 0.2
        dateView.layer.shadowRadius = 4.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
    }
}



