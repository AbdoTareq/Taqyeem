//
//  MapVC.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/13/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit
import GoogleMaps


class MapVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var resturantLocation :  CLLocation!
    var myCurrentLocation : CLLocation = CLLocation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
//        if CLLocationManager.locationServicesEnabled() {
//
//            locationManager.requestLocation()
//
//
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
        setupLocation()
        mapView.delegate = self
        self.addMarker(location: resturantLocation, markerName: "marker")
    }
    
    
    func setupLocation()  {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
}
extension MapVC: CLLocationManagerDelegate  , GMSMapViewDelegate{
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.requestLocation()
        
        
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
    }
    
    func addMarker(location :CLLocation , markerName :String)   {
         let marker = GMSMarker()
               marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
               marker.icon = UIImage(named: markerName)
               marker.map = mapView
    }
    func startDrawRout()  {
        var myLocation  =  CLLocationCoordinate2D(latitude: self.myCurrentLocation.coordinate.latitude, longitude:  self.myCurrentLocation.coordinate.longitude)
         var resLocation  =  CLLocationCoordinate2D(latitude: self.resturantLocation.coordinate.latitude, longitude:  self.resturantLocation.coordinate.longitude)
        
        self.drawLine(from: myLocation, to: resLocation)
    }
    
    
    func drawLine(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        let origin = "\(from.latitude),\(from.longitude)"
        let destination = "\(to.latitude),\(to.longitude)"
        
        //"30.083520,31.202073"
        
              let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyBhfdHUoQrmn85ARcBxZPaO9dNxssz9wSo"
              
              let url = URL(string: urlString)
              // (self.view as! GMSMapView).clear()
              URLSession.shared.dataTask(with: url!, completionHandler: {
                  (data, response, error) in
                  if(error != nil){
                      print("error")
                  }else{
                      do{
                          let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                          let routes = json["routes"] as! NSArray
                          
                          OperationQueue.main.addOperation({
                              if routes.count == 0 {
                                  return
                              }
                              let routeOverviewPolyline: NSDictionary = (routes[0] as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                              let points = routeOverviewPolyline.object(forKey: "points")
                              let path = GMSPath.init(fromEncodedPath: points! as! String)
                              let polyline = GMSPolyline.init(path: path)
                              polyline.strokeWidth = 3
                            polyline.strokeColor = UIColor.red
                              
                              let bounds = GMSCoordinateBounds(path: path!)
                            (self.mapView!).animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
                            polyline.map = (self.mapView)
                     
                              self.updateZoom()
                          })
                      }catch let error as NSError{
                          print("error:\(error)")
                      }
                  }
              }).resume()
    }

    func updateZoom() {
          (self.mapView).animate(toZoom: 10)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.myCurrentLocation = location
        let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 17.0)

        self.mapView?.animate(to: camera)
        self.addMarker(location: location, markerName: "location")
       self.locationManager.stopUpdatingLocation()
        self.startDrawRout()
    }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
}
