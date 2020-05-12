//
//  ViewController.swift
//  COVID survival guide
//
//  Created by Riley Bowling on 4/16/20.
//  Copyright © 2020 Riley Bowling. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var region = MKCoordinateRegion()
    var groceryBool = false
    var pharmacyBool = false
    var gasBool = false
    //var groceryData = Int()
    //var pharmacyData = Int()
    //var gasData = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let request = MKLocalSearch.Request()
        if groceryBool == true {
            print("grocery is true")
            request.naturalLanguageQuery = "grocery"
        }
        if pharmacyBool == true {
            print("pharmacy is true")
            request.naturalLanguageQuery = "pharmacy"
        }
         if gasBool == true {
            request.naturalLanguageQuery = "gas"
        }
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                for mapItem in response.mapItems {
                    print(mapItem.name!)
                }
            }
        }
    }
}

