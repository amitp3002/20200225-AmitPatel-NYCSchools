//
//  SchoolDetailsViewController.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/24/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import UIKit
import MapKit

class SchoolDetailsViewController: UIViewController {

    @IBOutlet weak var mathScoreLabel: UILabel!
    
    @IBOutlet weak var readingScoreLabel: UILabel!
    
    @IBOutlet weak var writingScoreLabel: UILabel!
    

    @IBOutlet weak var faxNumber: UITextView!
    
    
    @IBOutlet weak var phoneNumber: UITextView!
    
    @IBOutlet weak var emailAddress: UITextView!
    
 
    @IBOutlet weak var websiteURL: UITextView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var schoolDetails:SchoolDetailsViewModel?
    
    // MARK: View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContactInfoView()
        configureLocationInfoView()
        configureAPClassesView()
        configureEntranceRequirementsInfoView()
        
        // Do any additional setup after loading the view.
        setupSATScores()
    }
    
    // MARK:- Private methods
    
    private func setupSATScores() {
        if let sd = self.schoolDetails {
            DispatchQueue.global(qos: .userInitiated).async {
                sd.dataModel.getSchoolSATScoresFor(identifier:sd.dataModel.dbn) { (data, response, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            print("Error getting SAT scores")
                        }
                    } else {
                        if data?.count ?? 0 > 0 {
                            DispatchQueue.main.async {
                                if let satData = data {
                                    self.configureSATView(scores:satData)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // TO DO check Voice Over accessibility
    private func configureSATView(scores:[String : Any]) {
        mathScoreLabel.text = schoolDetails?.getMathSATScore(scores)
        readingScoreLabel.text = schoolDetails?.getReadingSATScore(scores)
        writingScoreLabel.text = schoolDetails?.getWritingSATScore(scores)
    }
    
    // TO DO check Voice Over accessibility
    private func configureContactInfoView() {
        faxNumber.text = schoolDetails?.getFaxNumber()
        phoneNumber.text = schoolDetails?.getPhoneNumber()
        emailAddress.text = schoolDetails?.getEmailAddress()
        websiteURL.text = schoolDetails?.getWebsiteUrl()
    }
    
    // TO DO check Voice Over accessibility
    private func configureLocationInfoView() {
        addressLabel.text = schoolDetails?.getMailingAddress()
        let school = MKPointAnnotation()
        school.title = schoolDetails?.getSchoolName()
        school.coordinate = schoolDetails?.getLatLon() ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        mapView.addAnnotation(school)
        mapView.centerCoordinate = school.coordinate
        let distance = 5000.0
        let region = MKCoordinateRegion( center: school.coordinate, latitudinalMeters: CLLocationDistance(exactly: distance)!, longitudinalMeters: CLLocationDistance(exactly: distance)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    private func configureAPClassesView() {
        // TO DO implement and add AP classes view to the stack view
        return
    }
    
    private func configureEntranceRequirementsInfoView() {
        // TO DO implement and add entrance requirements info view to the stack view
        return
    }
}



