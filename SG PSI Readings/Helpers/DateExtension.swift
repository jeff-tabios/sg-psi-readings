//
//  DateExtension.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 15/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

extension Date{
    func toString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        return formatter.string(from: self)
    }
}
