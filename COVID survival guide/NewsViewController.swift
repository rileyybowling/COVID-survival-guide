//
//  NewsViewController.swift
//  COVID survival guide
//
//  Created by Riley Bowling on 5/15/20.
//  Copyright © 2020 Riley Bowling. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    var places = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "places"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            let query = "https://api.covid19api.com/summary"
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse (json: JSON) {
        for result in json["Countries"].arrayValue {
            let name = result["Country"].stringValue
            let totalConfirmed = result["TotalConfirmed"].stringValue
            let totalDeaths = result["TotalDeaths"].stringValue
            let totalRecovered = result["TotalRecovered"].stringValue
            let place = ["Country": name, "TotalConfirmed": totalConfirmed, "TotalDeaths": totalDeaths, "TotalRecovered": totalRecovered]
            places.append(place)
        }
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the news feed", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place["Country"]
        
        return cell
    }
}
