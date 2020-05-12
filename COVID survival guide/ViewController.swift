//
//  ViewController.swift
//  COVID survival guide
//
//  Created by Riley Bowling on 4/16/20.
//  Copyright © 2020 Riley Bowling. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var grocerySwitch: UISwitch!
    @IBOutlet weak var groceryLabel: UILabel!
    @IBOutlet weak var pharmacySwitch: UISwitch!
    @IBOutlet weak var pharmacyLabel: UILabel!
    @IBOutlet weak var gasSwitch: UISwitch!
    @IBOutlet weak var gasLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    var groceryBool = false
    var pharmacyBool = false
    var gasBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func grocerySwitchTapped(_ sender: Any) {
        if grocerySwitch.isOn == true {
            groceryBool = true
        }
    }
    
    @IBAction func pharmacySwitchTapped(_ sender: Any) {
        if pharmacySwitch.isOn == true {
            pharmacyBool = true
        }
    }
    
    @IBAction func gasSwitchTapped(_ sender: Any) {
        if gasSwitch.isOn == true {
            gasBool = true
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ShowMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        let dvc = segue.destination as! MapViewController
        dvc.groceryBool = groceryBool
        dvc.pharmacyBool = pharmacyBool
        dvc.gasBool = gasBool
    }
}

