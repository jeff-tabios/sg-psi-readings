//
//  PSIReadingTest.swift
//  SG PSI ReadingsTests
//
//  Created by Jeff Tabios on 14/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Networking
@testable import SG_PSI_Readings

class NetworkAPITest: XCTestCase {
    
    let api = API()
    
    func test_mockRequest_returnsReading(){
        api.mockRequest("sample") { (reading) in
            expect(reading).notTo(beNil())
        }
    }
    
    func test_requestWithDateTime_returnsReading(){
        
        api.liveRequest(date: "2019-07-13T12:00:00") { (reading,readingError) in
            expect(reading).notTo(beNil())
        }
    }
    
    func test_requestWithDate_returnsReading(){
        
        api.liveRequest(date: "2019-07-13") { (reading,readingError) in
            expect(reading).notTo(beNil())
        }
    }
    
    func test_requestWitouthDate_returnsReading(){
        
        api.liveRequest() { (reading,readingError) in
            expect(reading).notTo(beNil())
        }
    }
    
    
}
