//
//  Constants.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/24/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import Foundation

struct Constants {
    static let appToken = "PKs81MUPe1nsayEKWywHF5Oz8"  // TO DO This API key should be read from an encrypted file or retrieved from a backend server.
    static let endpoint = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let satEndpoint = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    static let httpField = "X-App-Token"
    static let httpMethod = "GET"
    static let contentType = "application/json"
    static let acceptHttpField = "Accept"
    static let schoolNameKey = "school_name"
    static let dbn = "dbn"
}
