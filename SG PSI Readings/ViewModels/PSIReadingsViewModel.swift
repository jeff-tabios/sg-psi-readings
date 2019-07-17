//
//  PSIReadingsViewModel.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 16/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import MapKit

enum Regions: String{
    case central = "central"
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
}

extension Regions: CaseIterable {}

protocol ReadingProtocol{
    func requestReading(params:[String:String],completion: @escaping()-> Void)
    func createAnnotations() -> [MKPointAnnotation?]
    func placeAnnotations(annotations:[MKPointAnnotation?])
}

class PSIReadingViewModel: ReadingProtocol{
    
    let api = API()
    var reading: Reading?=nil
    
    func requestReading(params:[String:String] = [:], completion: @escaping()-> Void) {
        api.liveRequest(params:params) { [weak self] (reading,readingError) in
            if let reading = reading {
                self?.reading = reading
                completion()
            }else{
                self?.reading=nil
                completion()
            }
        }
    }
    
    func createAnnotations() -> [MKPointAnnotation?] {
        
        var annotations:[MKPointAnnotation?] = []
        
        Regions.allCases.forEach {
            annotations.append(createAnnotation(regionName: $0.rawValue))
        }
        
        return annotations
        
    }
    func createAnnotation(regionName:String) -> MKPointAnnotation? {
        
        if let reading = self.reading {
            
            //Details
            if let subtitle = reading.items[0].readings["psi_twenty_four_hourly"]?[regionName] {
                let title = regionName
                let latitude = reading.regionMetadata.filter{$0.name == regionName}[0].labelLocation.latitude
                let longitude = reading.regionMetadata.filter{$0.name == regionName}[0].labelLocation.longitude
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let readingText = reading.items[0].readings.map{"\($0.key): \($0.value[regionName] ?? "")"}.joined(separator: "\n")
                
                //Create
                let regionAnnotation = RegionAnnotation(
                    title: "\(title.capitalized)\nLevel: \(subtitle)",
                    subtitle: "Level: \(subtitle)",
                    coordinate: coordinate,
                    readingText: readingText)
                
                return regionAnnotation.createAnnotation()
            }
           
        }
        
        return nil
        
    }
    
    func placeAnnotations(annotations: [MKPointAnnotation?]) {
        
    }
    
}
