//
//  GoogleMapController.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 21/12/22.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps



class GoogleMapController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    var timer = Timer()
    var isUpdateCurrentLocation :Bool = false
    let newPin = MKPointAnnotation()
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var parkinglotLocationsCollectionView: UICollectionView!
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var profileBtnPrp: UIButton!
    @IBOutlet weak var gmsMapVieww: GMSMapView!
    @IBOutlet weak var LocationsView: UIView!
    @IBOutlet weak var locationsViewTopConstruent: NSLayoutConstraint!
    var locationManager = CLLocationManager()
    let marker = GMSMarker()
    let fullSizeOfScreen = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = ZoomAndSnapFlowLayout()
        parkinglotLocationsCollectionView.collectionViewLayout = flowLayout
        if let layout = parkinglotLocationsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal  // .horizontal
            }
        parkinglotLocationsCollectionView.contentInsetAdjustmentBehavior = .always
        searchBgView.layer.cornerRadius = 25.0
        searchBgView.layer.masksToBounds = true
        searchBgView.layer.borderWidth = 0.5
        searchBgView.layer.borderColor = UIColor.lightGray.cgColor
        
        profileBtnPrp.layer.cornerRadius = profileBtnPrp.frame.size.height/2
        profileBtnPrp.layer.masksToBounds = true
        
        parkinglotLocationsCollectionView.delegate = self
        parkinglotLocationsCollectionView.dataSource = self
        drawGoogleApiDirections()
        LocationsView.layer.cornerRadius = 40.0
        LocationsView.layer.masksToBounds = true
        locationsViewTopConstruent.constant = fullSizeOfScreen - fullSizeOfScreen/2
        
   
            gmsMapVieww.settings.myLocationButton = true
            gmsMapVieww.settings.zoomGestures = true
            gmsMapVieww.animate(toViewingAngle: 45)
            gmsMapVieww.delegate = self
        gmsMapVieww.animate(toZoom: 11.0)
        searchTxtFld.delegate = self
        
       showLocation()
        

    }


    
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        revealViewController()?.revealSideMenu()
    }

    func showLocation(){
        self.gmsMapVieww.isMyLocationEnabled = true
        
       // self.gmsMapVieww.camera = .init(latitude: coordinate.latitude, longitude: coordinate.longitude), zoom: 15.0)
    }
    
    func createPin(coordinate: CLLocationCoordinate2D) {
        
        let pin = GMSMarker(position:  coordinate)
        pin.icon = GMSMarker.markerImage(with: .brown)
        pin.appearAnimation = .pop
        pin.map = gmsMapVieww
        
        navigateToGMSLocation()
    }
    
    
    func navigateToGMSLocation(){
        let location = GMSCameraPosition.camera(withLatitude: 17.472502, longitude: 80.662087, zoom: 12.0)
        gmsMapVieww.animate(to: location)
        gmsMapVieww.camera = location
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let newLocation = locations.last // find your device location
//        gmsMapVieww.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
//        gmsMapVieww.settings.myLocationButton = true // show current location button
//        let lat = (newLocation?.coordinate.latitude)! // get current location latitude
//        let long = (newLocation?.coordinate.longitude)! //get current location longitude
//
//        marker.position = CLLocationCoordinate2DMake(lat,long)
//        marker.map = gmsMapVieww
//        print("Current Lat Long - " ,lat, long )
//    }

//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        mapView.clear()
//        DispatchQueue.main.async {
//            let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            self.marker.position = position
//            self.marker.map = mapView
//            self.marker.icon = UIImage(named: "default_marker")
//            print("New Marker Lat Long - ",coordinate.latitude, coordinate.longitude)
//        }
//    }
    
    
    
    
    
    func drawGoogleApiDirections(){
        let rect = GMSMutablePath()
        rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))

        // Create the polygon, and assign it to the map.
        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.05);
        polygon.strokeColor = .black
        polygon.strokeWidth = 2
        polygon.map = gmsMapVieww
        
//        let origin = "\(17.393480),\(78.559647)"
//        let destination = "\(17.559490),\(78.013050)"
//        let urlString = "https://maps.googleapis.com/maps/api/distabcematrix/json?origin=\(origin)&destinations=\(destination)&units=imperial&mode=driving&language=en-EN&sensor=false&key=AIzaSyD8kXLBho6UWzKO__vdSdlbM2r3Ipm5GOs"
//        let url = URL(string: urlString)
//        URLSession.shared.dataTask(with: url!, completionHandler: {
//            (data, response, error) in
//            if (error != nil){
//                print("errror")
//            } else {
//                DispatchQueue.main.async {
//                    self.gmsMapVieww.clear()
//
//                }
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
//                    let routes = json["routes"] as! NSArray
//                    self.getTotalDistance()
//                    OperationQueue.main.addOperation( {
//                        for route in routes {
//                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
//                            let points = routeOverviewPolyline.object(forKey: "points")
//                            let path = GMSPath.init(fromEncodedPath: points! as! String)
//                            let polyline = GMSPolyline.init(path: path)
//                            polyline.strokeWidth = 3
//                            polyline.strokeColor = UIColor(red: 50/255, green: 165/255, blue: 102/255, alpha: 1.0)
//
//                            let bounds = GMSCoordinateBounds(path: path!)
//                            self.gmsMapVieww!.animate(with: GMSCameraUpdate.fit(bounds,withPadding: 30.0))
//                            polyline.map = self.gmsMapVieww
//                        }
//                    })
//                }catch let error as NSError {
//                    print("error: \(error)")
//                }
//            }
//        }).resume()
    }
    
    
    func getTotalDistance(){
        let origin = "\(17.393480),\(78.559647)"
        let destination = "\(17.559490),\(78.013050)"
        let urlString = "https://maps.googleapis.com/maps/api/distabcematrix/json?origin=\(origin)&destinations=\(destination)&units=imperial&mode=driving&language=en-EN&sensor=false&key=AIzaSyD8kXLBho6UWzKO__vdSdlbM2r3Ipm5GOs"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if (error != nil){
                print("errror")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    let rows = json["rows"] as! NSArray
                    print(rows)
                    let dic = rows[0] as! Dictionary<String, Any>
                    let elements = dic["elements"] as! NSArray
                    let dis = elements[0] as! Dictionary<String, Any>
                    let distaneMiles = dis["distance"] as! Dictionary<String, Any>
                    let miles = distaneMiles["text"] as! String
                    print("\(miles.replacingOccurrences(of: " mi", with: ""))")
                } catch let error as NSError{
                    print("error:\(error)")
                }
            }
        }).resume()
    }
    
    
}


extension GoogleMapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        createPin(coordinate: coordinate)
    }
}



extension GoogleMapController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int) {
        print("row number is \(row)")
    }
    
    static  var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
   
    static var dictObject = [["parkinglotName":"Whoopee Parking Lot","parkingImg":"whoope.jpeg", "parkingLocation":" 1-2/1/24/A/1,7,plot no 17, Hitech City Main Rd, Khanammet, Telangana 500081", "contactNo":"9801253214"],["parkinglotName":"Happy Camper Lot","parkingImg":"HappyCamper.jpeg", "parkingLocation":"Gachibowli, opp to sujatha gas agency","contactNo":"9801253214"],["parkinglotName":"Good Spot Lot.","parkingImg":"GoodSpot.jpeg", "parkingLocation":"Habsiguda, Street no 8., Telangana, Hyderabad 500039","contactNo":"89434348393"],["parkinglotName":"Friendly City Carpark.","parkingImg":"FriendlyCity.jpeg", "parkingLocation":"Lb nagar, New thing , Telangana, Hyderabad 500039","contactNo":"89434348393"],["parkinglotName":"Eager Beaver Parking.","parkingImg":"EagerBeaver.jpeg", "parkingLocation":"Ghatkeser, Infosys, Telangana, Hyderabad 500039","contactNo":"89434348393"],["parkinglotName":"Friendly City Carpark.","parkingImg":"airportParking.jpeg", "parkingLocation":"Shamsabad airport, Telangana, Hyderabad 500039","contactNo":"8884325454"]]
      
      // MARK: - UICollectionViewDataSource protocol
      
      // tell the collection view how many cells to make
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return GoogleMapController.dictObject.count
      }
      
      // make a cell for each cell index path
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let obj = GoogleMapController.dictObject[indexPath.row]
          // get a reference to our storyboard cell
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParkingDetailsCollectionViewCell", for: indexPath as IndexPath) as! ParkingDetailsCollectionViewCell
          
          // Use the outlet in our custom class to get a reference to the UILabel in the cell
          cell.parkinglotTitleLbl.text = obj["parkinglotName"] ?? "" // The row value is the same as the index of the desired text within the array.
          cell.parkingImg.image = UIImage(named: obj["parkingImg"]  ?? "")
          cell.parkingLotLocationDetails.text = obj["parkingLocation"] ?? ""
          cell.parkingOwnerPhoneNo.text = obj["contactNo"] ?? ""
          let colorTop =  UIColor.white
          let colorBottom = UIColor(red: 76.0/255.0, green: 92.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
                         
             let gradientLayer = CAGradientLayer()
             gradientLayer.colors = [colorTop, colorBottom]
             gradientLayer.locations = [0.0, 0.5]
             gradientLayer.frame = self.view.bounds
                     
             cell.contentView.layer.insertSublayer(gradientLayer, at:0)
//          parkinglotLocationsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

          return cell
      }
      
      // MARK: - UICollectionViewDelegate protocol
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          // handle tap events
          print("You selected cell #\(indexPath.item)!")
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        var collectionCellHeight = screenHeight - locationsViewTopConstruent.constant
        collectionCellHeight = collectionCellHeight - collectionCellHeight/3
        return CGSize(width: screenWidth - screenWidth/2, height: collectionCellHeight)
       }
    
    
    func showPinnedLocation(locationLat:Double,locationLog:Double){
        
    }
}


extension GoogleMapController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(textField.text as? String ?? "")
        return true
    }
}


extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero

        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }

        layer.colors = layerColorSet
        layer.locations = layerLocations

        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }

        self.layer.insertSublayer(layer, above: self.layer)
    }
}
