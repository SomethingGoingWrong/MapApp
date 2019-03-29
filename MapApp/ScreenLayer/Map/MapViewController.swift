//
//  ViewController.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import UIKit
import PromiseKit
import GoogleMaps

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: MapView!
  
  var presenter : MapPresenter!
  
  var marker : GMSMarker?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.mapView.delegate = self
    mapView.configureView()
    presenter?.attachView(self)
    presenter?.obtainCitiesNamesWhenGameStarts()
    configureButton()
  }
  
  deinit {
    print("Map view controller was deinited!")
  }
  
  func configureButton() {
    self.mapView.buttonTapped = { [unowned self] in
      if let marker = self.marker{
        self.presenter?.didPressButton(with: marker)
      } else {
        Alert.showAddMarkerAlert(on: self)
      }
      self.mapView.mapView.clear()
      self.marker = nil
    }
  }
}

extension MapViewController: MapProtocol{
  func restart() {
    mapView.scoreLabel.text = "Your score is: 0"
    mapView.kilometersLabel.text = "Kilometers left: 1500"
  }
  
  func updateView(with city: String, with score: Int, with kilometers: Int) {
    mapView.cityLabel.text = city
    mapView.scoreLabel.text = "Your score is: \(score)"
    mapView.kilometersLabel.text = "Kilometers left: \(kilometers)"
  }
  
  func congigureWithCity(with city: String) {
    mapView.cityLabel.text = city
  }
  
  func winGameAlert(with score: Int) {
    Alert.gameWinAllert(on: self, with: score)
  }
  
  func lostGameAlert() {
    Alert.gameOverAtert(on: self)
  }
  
  func firebaseErrorAlert() {
    Alert.showFirebaseAlers(on: self)
  }
  
  func locationErrorAlert() {
    Alert.showLocationAlers(on: self)
  }
  
  func correctAnserAlert() {
    Alert.showCorrectAnswerAlert(on: self)
  }
  
  func wrongAnswerAllert(with distance: Int) {
    Alert.showWrongAnswerAlert(on: self, with: distance)
  }
  
}

extension MapViewController: GMSMapViewDelegate{
  func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
    self.mapView.chooseButton.isEnabled = true
    self.mapView.mapView.clear()
    let marker = GMSMarker()
    marker.position = coordinate
    marker.title = "Choosed location"
    marker.map = self.mapView.mapView
    self.marker = marker
  }
}

