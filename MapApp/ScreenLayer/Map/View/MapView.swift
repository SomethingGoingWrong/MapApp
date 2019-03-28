//
//  MapView.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

@IBDesignable class MapView: BaseView{
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var kilometersLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var chooseButton: UIButton!
  
  var buttonTapped: (() -> Void)?
  
  @IBAction func buttonPressed(_ sender: UIButton){
    buttonTapped?()
  }
  
}

extension MapView{
  func configureView(){
    chooseButton.isEnabled = false
    self.mapView.makeMapStyle(withFilename: "style", andType: "json")
    kilometersLabel.layer.cornerRadius = 8
    kilometersLabel.layer.masksToBounds = true
    scoreLabel.layer.cornerRadius = 8
    scoreLabel.layer.masksToBounds = true
    chooseButton.layer.cornerRadius = 5
  }
}

