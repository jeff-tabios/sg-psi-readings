//
//  PSIReadingsViewModel.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 16/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import MapKit

enum Regions{
    case central
    case north
    case south
    case east
    case west
}

protocol ReadingProtocol{
    func requestReading(params:[String:String],completion: @escaping()-> Void)
    func createAnnotations() -> [MKPointAnnotation?]
    func placeAnnotations(annotations:[MKPointAnnotation?])
}

class PSIReadingViewModel: ReadingProtocol{
    
    let api = API()
    var reading: Reading?
    
    func requestReading(params:[String:String] = [:], completion: @escaping()-> Void) {
        api.liveRequest(params:params) { (reading,readingError) in
            if let reading = reading {
                self.reading = reading
                completion()
                return
            }
        }
    }
    
    func createAnnotations() -> [MKPointAnnotation?] {
        
        var annotations:[MKPointAnnotation?] = []
        
        annotations.append(createAnnotation(regionName: "central"))
        annotations.append(createAnnotation(regionName: "north"))
        annotations.append(createAnnotation(regionName: "south"))
        annotations.append(createAnnotation(regionName: "west"))
        annotations.append(createAnnotation(regionName: "east"))
        
        return annotations
        
    }
    func createAnnotation(regionName:String) -> MKPointAnnotation? {
        
        if let reading = self.reading {
            
            //Details
            let title = regionName
            let subtitle = reading.items[0].readings["psi_twenty_four_hourly"]?[regionName]
            let latitude = reading.regionMetadata.filter{$0.name == regionName}[0].labelLocation.latitude
            let longitude = reading.regionMetadata.filter{$0.name == regionName}[0].labelLocation.longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let readingText = reading.items[0].readings.map{"\($0.key): \($0.value[regionName] ?? "")"}.joined(separator: "\n")
            
            //Create
            let regionAnnotation = RegionAnnotation(title: title,
                                                    subtitle: "Level: \(subtitle)",
                                           coordinate: coordinate,
                                           readingText: readingText)
            
            return regionAnnotation.createAnnotation()
        }
        
        return nil
        
    }
    
    func placeAnnotations(annotations: [MKPointAnnotation?]) {
        
    }
    
}
