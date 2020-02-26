//
//  ViewController.swift
//  NYCSchools
//
//  Created by Amit Patel on 2/23/20.
//  Copyright © 2020 Amit Patel. All rights reserved.
//

import UIKit

class SchoolsListViewController: UIViewController {

    struct Constants {
        static let xibName = "SchoolTableViewCell"
        static let cellID = "SchoolCellID"
        static let schoolDetailsID = "SchoolDetails"
    }
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var schools = SchoolViewModel()
    
    // MARK:- View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.startAnimating()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Private methods
    
    private func setupTableView() {
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.rowHeight = UITableView.automaticDimension
        tabelView.estimatedRowHeight = CGFloat(150.0)
        tabelView.register(UINib(nibName: Constants.xibName, bundle: Bundle.main), forCellReuseIdentifier: Constants.cellID)
        DispatchQueue.global(qos: .userInitiated).async {
            self.schools.dataModel.getSchools { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.activitySpinner.stopAnimating()
                        self.showError()
                    }
                } else {
                    if data?.count ?? 0 > 0 {
                        DispatchQueue.main.async {
                            self.tabelView.reloadData()
                            self.activitySpinner.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Could not connect or network error.  Please try again later", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showSchoolDetails(_ index:Int) {
        let story = UIStoryboard(name: Constants.schoolDetailsID, bundle: Bundle.main)
        let vc = story.instantiateViewController(identifier: Constants.schoolDetailsID) as SchoolDetailsViewController
        let dict = schools.dataModel.schoolList?[index]
        if let dictDetails = dict {
            vc.schoolDetails = SchoolDetailsViewModel(dict: dictDetails)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Could not show details view controller.  Check data at index \(index)!")
        }
    }
}

// MARK:- UITableView datasource and UITableView delegate methods

extension SchoolsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = schools.dataModel.schoolList?.count {
            print("Count is \(count)")
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.cellID) as! SchoolTableViewCell
        let result = schools.configureView(index:indexPath.row)
        cell.configureCellWithName(result.name, overView: result.overview)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSchoolDetails(indexPath.row)
    }
}

