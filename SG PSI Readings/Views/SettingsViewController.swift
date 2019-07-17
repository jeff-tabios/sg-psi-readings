//
//  SettingsViewController.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 16/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsProtocol: class {
    func refreshFromSettings(date:String)
}

class SettingsViewController: UIViewController{
    
    weak var delegate: SettingsProtocol?
    @IBOutlet weak var dtPicker: UIDatePicker!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func refresh(_ sender: Any) {
        if dtPicker.date <= Date() {
            delegate?.refreshFromSettings(date: dtPicker.date.toString())
            dismiss(animated: true, completion: nil)
            
        }
    }
}
