//
//  LocationService.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit

protocol LocationService{
  func getLocation(of city: String) -> Promise<CLLocation>
  func getDistanceBetween(marker: CLLocation, coordinate: CLLocation) -> Int
}

class LocationServiceImpl: NSObject, LocationService {
  func getLocation(of city: String) -> Promise<CLLocation>{
    return Promise<CLLocation> { seal -> Void in
      return CLGeocoder().geocodeAddressString(city, completionHandler: { (placemark, error) in
        if let placemark = placemark{
          if let location = placemark.first?.location{
            seal.fulfill(location)
          }
        }else if let error = error{
          seal.reject(error)
        }
      })
    }
  }
  
  func getDistanceBetween(marker: CLLocation, coordinate: CLLocation) -> Int{
    let distance = marker.distance(from: coordinate)
    let convertedDistance = Int(distance).covertToKM()
    return convertedDistance
  }
}
