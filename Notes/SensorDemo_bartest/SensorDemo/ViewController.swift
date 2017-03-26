//
//  ViewController.swift
//  SensorDemo
//
//  Created by Gene Lee on 3/7/17.
//  Copyright © 2017 Gene Lee. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - CoreMotion
    
    @IBOutlet weak var yawLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var rollLabel: UILabel!
    
    var motionManager: CMMotionManager!
    
    func initializeMotion() { // called from start up method
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = 0.1 // secs
    }
    
    func startMotion () {
        self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: motionHandler)
    }
    
    func stopMotion () {
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func motionHandler (deviceMotion: CMDeviceMotion?, error: Error?) {
        if let err = error {
            NSLog("motionHandler error: \(err.localizedDescription)")
        } else {
            if let dm = deviceMotion {
                //print("Attitude: yaw = \(dm.attitude.yaw), pitch = \(dm.attitude.pitch), roll = \(dm.attitude.roll)")
                //print("Acceleration: x = \(dm.userAcceleration.x), y = \(dm.userAcceleration.y), z = \(dm.userAcceleration.z)")
                
                let yaw = String(format: "%.5f", dm.attitude.yaw)
                let pitch = String(format: "%.5f", dm.attitude.pitch)
                let roll = String(format: "%.5f", dm.attitude.roll)
                
                self.yawLabel.text = "Yaw = \(yaw)"
                self.pitchLabel.text = "Pitch = \(pitch)"
                self.rollLabel.text = "Roll = \(roll)"
                
                // for the start test button
                if (dm.attitude.pitch > self.tolerance) || (dm.attitude.pitch < -self.tolerance) {
                    self.toleranceExceeded = true
                }
                if (dm.attitude.roll > self.tolerance) || (dm.attitude.roll < -self.tolerance) {
                    self.toleranceExceeded = true
                }
                
            } else {
                NSLog("motionHandler: deviceMotion = nil")
            }
        }
    }
    
    // MARK: - views functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeMotion()
        self.initializeLocation()
        self.mapView.userTrackingMode = .follow
        self.passFailLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.startMotion()
        
        let status = CLLocationManager.authorizationStatus()
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) {
            self.startLocation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopMotion()
        self.stopLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CoreLocation

    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
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
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) {
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
    
    // Delegate method called whenever location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        self.globalLocation = location
        if let latitude = location?.coordinate.latitude {
            //print("Latitude: \(latitude)")
            let latString = String(format: "%.5f", latitude)
            self.latLabel.text = "Latitude: \(latString)"
        }
        if let longitude = location?.coordinate.longitude {
            //print("Longitude: \(longitude)")
            let longString = String(format: "%.5f", longitude)
            self.longLabel.text = "Longitude: \(longString)"
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Reverse Geocoding
    
    @IBAction func getInfoTapped(_ sender: UIButton) {
        // Initiate lookup of location
        geoCoder.reverseGeocodeLocation(globalLocation, completionHandler: geoCodeHandler)
    }
    
    var geoCoder = CLGeocoder()
    
    var globalLocation: CLLocation! // set in didUpdateLocations
    
    func geoCodeHandler (placemarks: [CLPlacemark]?, error: Error?) { if let placemark = placemarks?.first {
            if let name = placemark.name {
                print("place name = \(name)")
            }
        }
    }
    
    // MARK: - MapKit Annotations (i.e. Pizza)
    
    @IBAction func pizzaButtonTapped(_ sender: UIButton) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "pizza"
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
    
    // MARK: - Start Moving Test
    
    let tolerance = 0.1
    var toleranceExceeded = false
    let timerDuration = 5.0
    
    @IBOutlet weak var passFailLabel: UILabel!
    @IBOutlet weak var startTestButton: UIButton!
    @IBAction func startTestTapped(_ sender: UIButton) {
        self.toleranceExceeded = false
        self.startTestButton.isEnabled = false
        self.passFailLabel.isHidden = true
        Timer.scheduledTimer(withTimeInterval: timerDuration, repeats: false, block: testOver)
    }
    
    func testOver (_ timer: Timer) {
        DispatchQueue.main.async { // so that it doesnt go into a different thread and label doesnt show up
            self.startTestButton.isEnabled = true
            if self.toleranceExceeded {
                self.passFailLabel.text = "FAIL!"
            } else {
                self.passFailLabel.text = "PASS!"
            }
            self.passFailLabel.isHidden = false
        }
        
    }
}

