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
    
    func test_mockRequest_returnsReading(){
        
        let api = API()
        api.mockRequest("sample") { (reading) in
            if reading != nil{
                XCTAssert(true)
            }else{
                XCTAssert(false)
            }
        }
        
    }
    
    func test_requestWithDateTime_returnsReading(){
        let api = API()
        
        let targetDateTime = "2019-07-13T12:00:00"
        
        api.liveRequest(dateTime: targetDateTime) { (reading,readingError) in
            if reading != nil {
                XCTAssert(true)
            }else{
                XCTAssert(false)
            }
        }
    }
    
    func test_requestWithDate_returnsReading(){
        let api = API()
        
        let targetDateTime = "2019-07-13"
        
        api.liveRequest(date: targetDateTime) { (reading,readingError) in
            if reading != nil {
                XCTAssert(true)
            }else{
                XCTAssert(false)
            }
        }
    }
    
    func test_requestWitouthDate_returnsReading(){
        let api = API()
        
        api.liveRequest() { (reading,readingError) in
            if reading != nil {
                XCTAssert(true)
            }else{
                XCTAssert(false)
            }
        }
    }
    
    
}
