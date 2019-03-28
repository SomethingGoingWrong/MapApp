//
//  City.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation

struct City: Codable {
  let name: String
  let lat: Double
  let lon : Double
  
  init(name: String, lat: Double, lon: Double) {
    self.name = name
    self.lat = lat
    self.lon = lon
  }
}
