//
//  AppDelegate.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let window = UIWindow()


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    configureAppDelegate()
    presentMapViewController()
    return true
  }
  
}

extension AppDelegate{
  
  func configureAppDelegate(){
    configureGMS()
    configureFirebase()
  }
  
  func configureFirebase(){
    let firebaseService = ServiceAssembler.FireService()
    firebaseService.configure()
    
  }
  
  func configureGMS(){
    let gmsService = ServiceAssembler.GMSService()
    gmsService.configure()
  }
  
  func presentMapViewController(){
    let scoreService = ServiceAssembler.ScoreService()
    let firebaseService = ServiceAssembler.FireService()
    let locationService = ServiceAssembler.LocationService()
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
    vc?.presenter = MapPresenter(locationService: locationService, scoreService: scoreService, firebaseService: firebaseService)
    window.rootViewController = vc
    window.makeKeyAndVisible()
  }
}

