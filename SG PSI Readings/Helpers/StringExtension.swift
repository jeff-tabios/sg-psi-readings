//
//  StringExtension.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 15/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

extension String{
    func toDate() -> Date?{
        let format = DateFormatter()
        if self.count == 10{
            format.dateFormat = "yyyy-MM-dd"
        }else{
            format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        }
  
        if let date = format.date(from: self){
            return date
        }else{
            return nil
        }

        
    }
}
