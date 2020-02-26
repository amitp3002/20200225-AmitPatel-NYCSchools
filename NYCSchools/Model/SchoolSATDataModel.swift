//
//  SchoolSATDataModel.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/24/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import Foundation

/// Class to get average SAT scores for a given school ID (dbn).  Must call getSchoolsSATFor method on non main thread.
class SchoolSATDataModel {
    var dbn:String
    var satScores:[String:Any]
    
    // MARK:- Initialization
    init(dbn:String) {
        self.dbn = dbn
        self.satScores = [String : Any]()
    }
    
    // MARK:- REST API call
    
    func getSchoolSATScoresFor(identifier dbn:String, completionHandler:@escaping(_ result:[String:Any]?, _ response:URLResponse?, _ error:Error?)->Void)  {
            var fullEndpoint = Constants.satEndpoint
            fullEndpoint += "?dbn="
            fullEndpoint += dbn
            
            let session = URLSession.shared
         
            if let url = URL(string: fullEndpoint) {
                var request = URLRequest(url: url)
                request.addValue(Constants.appToken, forHTTPHeaderField: Constants.httpField)
                request.addValue(Constants.contentType, forHTTPHeaderField:Constants.acceptHttpField)
                request.httpMethod = Constants.httpMethod
                request.allowsCellularAccess = true
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
                            if array.count > 0 {
                                self.satScores = array[0]
                                completionHandler(array[0], response, error)
                                return
                            } else {
                                completionHandler(nil, response, error)
                            }

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
