//
//  MapPresenter.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import GoogleMaps
import PromiseKit
import CoreLocation

protocol MapProtocol: class {
  func congigureWithCity(with city: String)
  func updateView(with city: String, with score: Int, with kilometers: Int)
  func restart()
  func winGameAlert(with score: Int)
  func lostGameAlert()
  func firebaseErrorAlert()
  func locationErrorAlert()
  func correctAnserAlert()
  func wrongAnswerAllert(with distance: Int)
}

class MapPresenter{
  var locationService: LocationService!
  var scoreService: ScoreService!
  var firebaseService: FireService!
  
  weak var mapProtocol: MapProtocol!
  
  private var cities = [String]()
  
  init(locationService: LocationService, scoreService: ScoreService, firebaseService: FireService) {
    self.locationService = locationService
    self.scoreService = scoreService
    self.firebaseService = firebaseService
  }
  
  deinit {
    print("Map presenter was deinited!")
  }
  
  func attachView(_ view: MapProtocol) {
    self.mapProtocol = view
  }
  
  func deatachView() {
    self.mapProtocol = nil
  }
  
  private func obtainCityLocation(with city: String) -> CLLocation? {
    locationService?.getLocation(of: city)
      .done({ (location) in
        return location
      })
      .catch({ (error) in
        self.mapProtocol?.locationErrorAlert()
      })
    return nil
  }
  
  private func saveTimeAndScoreToFirebase() {
    let score = self.scoreService.score
    let date = Date()
    self.firebaseService.saveGameTime(from: .results, with: date, withScore: score)
  }
  
  private func restartGame() {
    self.scoreService?.restart()
    self.obtainCitiesNamesWhenGameStarts()
    self.mapProtocol?.restart()
  }
  
  func didPressButton(with marker: GMSMarker){
    let markerPosition = marker.position
    let cityCoordinates = locationService?.getLocation(of: cities.first!)
      .done({ (location) in
        //Do if location of city by name is successfully obtained
        if let distance = self.locationService?.getDistanceBetween(marker: CLLocation(latitude: markerPosition.latitude, longitude: markerPosition.longitude), coordinate: location){
          //Do if distance between points successfully obtained
          self.scoreService?.update(with: distance)
          self.cities.removeFirst()
          if self.scoreService!.kilometers > 0{
            //Do if kilometers left
            if let city = self.cities.first{
              //Do if cities left
              if distance < 50{ // Show correct or wrong answer allert
                self.mapProtocol?.correctAnserAlert()
              } else {
                self.mapProtocol?.wrongAnswerAllert(with: distance)
              }
              let score = self.scoreService!.score
              let kilometers = self.scoreService!.kilometers
              self.mapProtocol?.updateView(with: city, with: score, with: kilometers)
            } else {
              //Do if no more cities (Player WON)
              self.mapProtocol?.winGameAlert(with: self.scoreService!.score)
              self.restartGame()
            }
          } else {
            //Do if no more kilometers (Player LOST)
            self.saveTimeAndScoreToFirebase()
            self.mapProtocol?.lostGameAlert()
            self.restartGame()
          }
        }
      })
      .catch({ (error) in
        //Do if error with obtaining location by city name
        self.mapProtocol?.locationErrorAlert()
      })
  }
  
  
  func obtainCitiesNamesWhenGameStarts(){
    firebaseService?.readCities(from: .capitalCities, returning: City.self)
      .done({ (cities) in
        //Do if cities if successfully obtained from firebase
        for city in cities{
          self.cities.append(city.name)
        }
        self.cities.shuffle()
        if let name = self.cities.first{
          self.mapProtocol?.congigureWithCity(with: name)
        }
      })
      .catch({ (error) in
        //Do if error with obtainig cities from firebase
        self.mapProtocol?.firebaseErrorAlert()
      })
  }
  
}
