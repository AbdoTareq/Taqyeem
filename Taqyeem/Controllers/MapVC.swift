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
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self

        if CLLocationManager.locationServicesEnabled() {
         
          locationManager.requestLocation()

  
          mapView.isMyLocationEnabled = true
          mapView.settings.myLocationButton = true
        } else {
          locationManager.requestWhenInUseAuthorization()
        }
        mapView.delegate = self
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

 
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }

 
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    mapView.camera = GMSCameraPosition(
      target: location.coordinate,
      zoom: 6,
      bearing: 0,
      viewingAngle: 0)
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
    marker.icon = UIImage(named: "location")
    marker.map = mapView
  }


  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
}
