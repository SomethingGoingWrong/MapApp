//
//  ServiceAssembler.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation

class ServiceAssembler{
  static func FireService() -> FireService{
    return FireServiceImpl()
  }
  
  static func ScoreService() -> ScoreService{
    return ScoreServiceImpl()
  }
  
  static func GMSService() -> GMSService{
    return GMSServiceImpl()
  }
  
  static func LocationService() -> LocationService{
    return LocationServiceImpl()
  }
}
