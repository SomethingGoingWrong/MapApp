//
//  GMSMapView.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMapView {
  func makeMapStyle(withFilename name: String, andType type: String) {
    do {
      if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
        self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
      } else {
        NSLog("Unable to find style.json")
      }
    } catch {
      NSLog("One or more of the map styles failed to load. \(error)")
    }
  }
}
