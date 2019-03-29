//
//  GoogleMapsService.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import GoogleMaps

protocol GMSService {
  func configure()
}

class GMSServiceImpl: NSObject, GMSService {
  
  private let apiKey = "AIzaSyDmqwfqapC0pAAMnUq3mgpj8n-OZnCyd_A"
  
  func configure() {
    GMSServices.provideAPIKey(apiKey)
  }
}
