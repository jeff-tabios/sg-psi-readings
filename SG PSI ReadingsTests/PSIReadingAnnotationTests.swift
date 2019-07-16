//
//  PSIReadingAnnotationTests.swift
//  SG PSI ReadingsTests
//
//  Created by Jeff Tabios on 16/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Networking
@testable import SG_PSI_Readings

class PSIReadingAnnotationTests: XCTestCase {
 
    let PSIReadingVM = PSIReadingViewModel()
    
    func test_createAnnotations_returns5RegionAnnotations(){
        PSIReadingVM.requestReading(){
            if self.PSIReadingVM.reading != nil {
                let annotations = self.PSIReadingVM.createAnnotations()
                 expect(annotations).to(haveCount(5))
            }
        }
    }
}
