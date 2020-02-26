//
//  SchoolViewModel.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/23/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import Foundation

/// View Model used to populate the tableview showing the list of school names with short desciption of each school.
class SchoolViewModel {
    var dataModel = SchoolDataModel()
    
    func configureView(index:Int)->(name:String, overview:String) {
        let result = dataModel.schoolList?[index]
        let name = result?["school_name"] as? String
        let overview = result?["overview_paragraph"] as? String
        guard let schoolName = name,
        let over = overview else {
            return ("", "")
        }
        return (schoolName, over)
    }    
}
