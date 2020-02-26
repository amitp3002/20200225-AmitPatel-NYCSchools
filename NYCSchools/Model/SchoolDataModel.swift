//
//  SchoolDataModel.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/23/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import Foundation

/// Data model to get list of NYC (Ney York City) high schools.  You must call getSchools on a non main thread.
class SchoolDataModel {
    
    var schoolList:[[String:Any]]?
    
    
    // TO DO load first 5 quickly. Paging.
    func getSchools(completionHandler:@escaping(_ result:[[String:Any]]?, _ response:URLResponse?, _ error:Error?)->Void)  {
        
        let fullEndpoint = Constants.endpoint
       
        let session = URLSession.shared
    
        if let url = URL(string: fullEndpoint) {
            var request = URLRequest(url: url)
            request.addValue(Constants.appToken, forHTTPHeaderField: Constants.httpField)
            request.addValue(Constants.contentType, forHTTPHeaderField:Constants.acceptHttpField)
            request.httpMethod = Constants.httpMethod
            request.timeoutInterval = 10
            let sessionTask = session.dataTask(with: request) { (result, response, error) in
                
                if error == nil {
                       var jsonResult: Any!
                       do {
                           jsonResult = try JSONSerialization.jsonObject(with: result!, options: JSONSerialization.ReadingOptions.mutableContainers)
                       } catch let error {
                            jsonResult = nil
                            completionHandler(nil, response, error)
                            return
                       }
                    if let array = jsonResult as? [[String: Any]] {
                        self.schoolList = array
                        self.schoolList?.sort(by: { (dict1, dict2) -> Bool in
                            let school1 = dict1[Constants.schoolNameKey] as! String
                            let school2 = dict2[Constants.schoolNameKey] as! String
                            return school1 < school2
                        })
                        completionHandler(array, response, error)
                        return
                    } else {
                        completionHandler(nil, response, error)
                    }
                }
                else {
                    completionHandler(nil, response, error)
                }
            }
            sessionTask.resume()
        }
    }
}

