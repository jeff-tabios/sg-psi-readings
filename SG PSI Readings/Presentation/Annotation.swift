//
//  Annotation.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 16/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import MapKit

enum SafetyLevel{
    case good
    case moderate
    case unhealthy
    case veryUnhealthy
    case hazardous
}

protocol AnnotationProtocol{
    var title: String? {get set}
    var subTitle: String? {get set}
    var coordinate: CLLocationCoordinate2D? { get set }
    
    func createAnnotation()-> MKPointAnnotation?
}

class Annotation: AnnotationProtocol {
    var title: String?
    var subTitle: String?
    var coordinate: CLLocationCoordinate2D?
    
    func createAnnotation() -> MKPointAnnotation?{
        return nil
    }
    
}


class RegionAnnotation: Annotation {
    
    var readingText: String?
    
    init(title: String,
         subtitle: String,
         coordinate: CLLocationCoordinate2D,
         readingText: String) {
        super.init()
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
        self.readingText = readingText
    }
    
    override func createAnnotation() -> MKPointAnnotation?{
        let annotation = MKPointAnnotation()
        annotation.title = title
        guard let coordinate = coordinate else { return nil}
        annotation.coordinate = coordinate
        annotation.subtitle = subTitle
        
        return annotation
    }
}
