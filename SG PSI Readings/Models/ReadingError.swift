//
//  ReadingError.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 15/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - ReadingError
struct ReadingError: Codable {
    let code: Int
    let message: String
}
