//
//  FindBarViewController.swift
//  JokerBarBuddy
//
//  Created by Gene Lee on 3/25/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FindBarViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func showNearbyBarsTapped(_ sender: UIButton) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "bar"
        request.region = self.mapView.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("\(response!.mapItems.count) matches found")
                self.mapView.removeAnnotations(self.mapView.annotations)
                for item in response!.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
    
    func initializeLocation() { // called from start up method
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.startLocation()
        case .denied, .restricted:
            print("location not authorized")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // Delegate method called whenever location authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if (status == .authorizedWhenInUse) {
            self.startLocation()
        } else {
            self.stopLocation()
        }
    }
    
    func startLocation () {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopLocation () {
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initializeLocation()
        self.mapView.userTrackingMode = .follow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let status = CLLocationManager.authorizationStatus()
        if (status == .authorizedWhenInUse) {
            self.startLocation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
