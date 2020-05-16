//
//  NewsViewController.swift
//  COVID survival guide
//
//  Created by Riley Bowling on 5/15/20.
//  Copyright © 2020 Riley Bowling. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var places = [[String: String]]()
    @IBOutlet weak var totalConfirmedLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let query = "https://api.covid19api.com/summary"
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
            }
        }
    }
    
    func parse (json: JSON) {
        for result in json["Countries"].arrayValue {
            let name = result["Country"].stringValue
            let totalConfirmed = result["TotalConfirmed"].stringValue
            let totalDeaths = result["TotalDeaths"].stringValue
            let totalRecovered = result["TotalRecovered"].stringValue
            nameLabel.text! = "\(name)"
            totalConfirmedLabel.text! = "total confirmed cases: \(totalConfirmed)"
            totalDeathsLabel.text! = "total confirmed deaths: \(totalDeaths)"
            totalRecoveredLabel.text! = "total confirmed recoveries: \(totalRecovered)"
        }
    }
}
