//
//  API.swift
//  SG PSI Readings
//
//  Created by Jeff Tabios on 14/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import Networking

class API{
    
    func createParems(date:String?=nil) -> [String:String]{
        
        var params:[String:String] = [:]
        
        if let date = date {
            if date.count == 10{
                params["date"] = date
            }else{
                params["date_time"] = date
            }
        }
        
        return params
    }
    
    func liveRequest(date:String? = nil,
                     completion: @escaping (Reading?,ReadingError?)-> Void){
        
        let params = createParems(date: date)
        
        let networking = Networking(baseURL: NetworkConfig.baseUrl)
        networking.get(NetworkConfig.psiUrl,parameters: params) { (result) in
            
            switch result {
            case .success(let response):
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                guard let reading = try? decoder.decode(Reading.self, from: response.data) else{
                    completion(nil,nil)
                    return
                }
                
                completion(reading,nil)
                
            case .failure(let response):
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                guard let readingError = try? decoder.decode(ReadingError.self, from: response.data) else{
                    completion(nil,nil)
                    return
                }
                
                completion(nil,readingError)
                break
            }
            
        }
    }
    
    
    func mockRequest(_ filename: String, completion: (Reading?)-> Void) {
        if let path = Bundle.main.path(forResource: "sample", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                guard let reading = try? decoder.decode(Reading.self, from: data) else{
                    print("Error decoding data")
                    completion(nil)
                    
                    return
                }
                
                completion(reading)
                
            } catch {
                completion(nil)
            }
        }
    }
    
}
