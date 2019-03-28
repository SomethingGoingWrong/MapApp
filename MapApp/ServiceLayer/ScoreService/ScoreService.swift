//
//  ScoreService.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation

protocol ScoreService {
  var kilometers : Int {get set}
  var score : Int {get set}
  func update(with kilometers: Int)
  func restart()
}

class ScoreServiceImpl: NSObject, ScoreService {  
  var kilometers = 1500
  var score = 0
  
  func update(with kilometers: Int) {
    if kilometers <= 50{
      score += 1
    }else{
      self.kilometers -= kilometers
    }
  }
  
  func restart() {
    self.kilometers = 1500
    self.score = 0
  }
}
