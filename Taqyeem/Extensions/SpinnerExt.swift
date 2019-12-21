//
//  SpinnerExt.swift
//  Reach_Network
//
//  Created by Sameh sayed on 6/23/19.
//  Copyright © 2019 Reach. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit
import CoreLocation
import MapKit
import SystemConfiguration
extension UIView {
    func startLoadingActivity() {
        let data = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(data, nil)
    }

    func stopLoadingActivity() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}

extension UIViewController {
    func startLoadingActivity() {
        view.startLoadingActivity()
    }

    func stopLoadingActivity() {
        view.stopLoadingActivity()
    }
    @objc func openMapForLocation(location: CLLocation, zoom: Int, locationName: String, title: String, googleTitle: String, appleTitle: String, cancelTitle: String) {
           var type: UIAlertController.Style!

           if UIDevice.current.userInterfaceIdiom == .pad {
               type = .alert
           }
           else {
               type = .actionSheet
           }

           let alert = UIAlertController(title: title, message: "", preferredStyle: type)

           let appleBtn = UIAlertAction(title: appleTitle, style: .default) {
               _ in

               let regionDistance: CLLocationDistance = CLLocationDistance(zoom)
               let regionSpan = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
               let options = [
                   MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                   MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
               ]
               let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
               let mapItem = MKMapItem(placemark: placemark)
               mapItem.name = locationName
               mapItem.openInMaps(launchOptions: options)
           }

           let googleBtn = UIAlertAction(title: googleTitle, style: .default) {
               _ in

               UIApplication.shared.open(NSURL(
                   string:
                   "comgooglemaps://?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)&directionsmode=driving"
               )! as URL, options: [:], completionHandler: nil)
           }

           let cancelBtn = UIAlertAction(title: cancelTitle, style: .cancel) {
               _ in
           }

           alert.addAction(appleBtn)
           alert.addAction(googleBtn)
           alert.addAction(cancelBtn)

           present(alert, animated: true, completion: nil)
       }
}
