//
//  SchoolDetailsViewModel.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/24/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import Foundation
import MapKit

/// View Model for showing details about a given school including SAT scores, contact info and location info.
class SchoolDetailsViewModel {
    
    var schoolDetails:[String:Any]
    
    var dataModel:SchoolSATDataModel
    
    // MARK:- Initialization
    init(dict:[String : Any]) {
        let dbn = dict[Constants.dbn] as? String
        if let dbn = dbn {
            self.dataModel = SchoolSATDataModel(dbn: dbn)
            self.schoolDetails = dict
        } else {
            fatalError("Could not create SAT view model")
        }
    }
    
    // MARK:- Getters
    
    func getMathSATScore(_ scores:[String : Any])->String {
        return scores["sat_math_avg_score"] as? String ?? ""
    }
    
    func getReadingSATScore(_ scores:[String : Any])->String {
        return scores["sat_critical_reading_avg_score"] as? String ?? ""
    }
    
    func getWritingSATScore(_ scores:[String : Any])->String {
        return scores["sat_writing_avg_score"] as? String ?? ""
    }
    
    func getPhoneNumber()->String {
        return schoolDetails["phone_number"] as? String ?? ""
    }
    
    func getFaxNumber()->String {
        return schoolDetails["fax_number"] as? String ?? ""
    }
    
    func getEmailAddress()->String {
        return schoolDetails["school_email"] as? String ?? ""
    }
    
    func getWebsiteUrl()->String {
        return schoolDetails["website"] as? String ?? ""
    }
    
    func getMailingAddress()->String {
        guard let line1 = schoolDetails["primary_address_line_1"] as? String,
            let city = schoolDetails["city"] as? String,
            let state = schoolDetails["state_code"] as? String,
            let zip = schoolDetails["zip"] as? String else {
            return ""
        }
        return line1 + " " + city + " " + state + " " + zip
    }
    
    func getSchoolName()->String {
        return schoolDetails["school_name"] as? String ?? ""
    }
    
    func getLatLon()->CLLocationCoordinate2D {
        guard let lat = schoolDetails["latitude"] as? String,
            let lon = schoolDetails["longitude"] as? String else {
                return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        }
        if let latDouble = Double(lat) {
            if let lonDouble = Double(lon) {
                return CLLocationCoordinate2D(latitude: latDouble, longitude: lonDouble)
            }
        }
        return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
}

