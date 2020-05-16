//
//  DataViewController.swift
//  COVID survival guide
//
//  Created by Riley Bowling on 5/15/20.
//  Copyright © 2020 Riley Bowling. All rights reserved.
//

import UIKit

class CountriesViewController: UITableViewController {
    
    var places = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = "https://www.healthcare.gov/api/states.json"
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
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
        for result in json.arrayValue {
            let state = result["title"].stringValue
            let content = result["content"].stringValue
            let place = ["title": state, "content": content]
            places.append(place)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the news feed", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place["title"]
        print("it shoudlve show up")
        cell.detailTextLabel?.text = place["click to view details"]
        return cell
    }
}
