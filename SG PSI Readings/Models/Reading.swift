//
//  Reading.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 14/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

//   let reading = try? newJSONDecoder().decode(Reading.self, from: jsonData)

import Foundation

// MARK: - Reading
struct Reading: Codable {
    let regionMetadata: [RegionMetadatum]
    let items: [Item]
    let apiInfo: APIInfo
    
    enum CodingKeys: String, CodingKey {
        case regionMetadata = "region_metadata"
        case items
        case apiInfo = "api_info"
    }
}

// MARK: - APIInfo
struct APIInfo: Codable {
    let status: String
}

// MARK: - Item
struct Item: Codable {
    let timestamp, updateTimestamp: Date
    let readings: [String: ReadingValue]
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case updateTimestamp = "update_timestamp"
        case readings
    }
}

// MARK: - ReadingValue
struct ReadingValue: Codable {
    let west, national, east, central: Double
    let south, north: Double
}

// MARK: - RegionMetadatum
struct RegionMetadatum: Codable {
    let name: String
    let labelLocation: LabelLocation
    
    enum CodingKeys: String, CodingKey {
        case name
        case labelLocation = "label_location"
    }
}

// MARK: - LabelLocation
struct LabelLocation: Codable {
    let latitude, longitude: Double
}

