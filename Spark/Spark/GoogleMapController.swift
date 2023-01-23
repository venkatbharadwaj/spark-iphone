//
//  GoogleMapController.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 21/12/22.
//

import UIKit
import MapKit
import CoreLocation

class GoogleMapController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    var timer = Timer()
    var isUpdateCurrentLocation :Bool = false
    var locationManager: CLLocationManager!
    let newPin = MKPointAnnotation()
    @IBOutlet weak var mapViewww: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapViewww.delegate = self
        if (CLLocationManager.locationServicesEnabled())
                {
                    locationManager = CLLocationManager()
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.requestAlwaysAuthorization()
                    locationManager.startUpdatingLocation()
                }
        
        let locations = [
            ["title": "Little flower college",    "latitude": 17.4044553175, "longitude": 78.5572457314],
            ["title": "Los Angeles, CA", "latitude": 34.052238, "longitude": -118.243344],
            ["title": "Chicago, IL",     "latitude": 41.883229, "longitude": -87.632398]
        ]

        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            self.mapViewww.addAnnotation(annotation)
        }
        self.updateCurrentLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if self.isUpdateCurrentLocation == false {
        self.mapViewww.removeAnnotation(newPin)

        let location = locations.last! as CLLocation

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        //set region on the map
        self.mapViewww.setRegion(region, animated: true)
        newPin.title = "My Location"
        newPin.coordinate = location.coordinate
        self.mapViewww.addAnnotation(newPin)
        }
    }
    
    func updateCurrentLocation(){
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateLabel)), userInfo: nil, repeats: true){
//
//        }
      
        self.timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
             
            self.isUpdateCurrentLocation.toggle()
           })
        
        
    }
}
