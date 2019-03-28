//
//  Alertsmanager.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
  private static func showBasicAlert(on vc: UIViewController, with title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
  }
  
  static func gameOverAtert(on vc: UIViewController){
    showBasicAlert(on: vc, with: "GAME OVER", message: "Better luck next time :)")
  }
  
  static func gameWinAllert(on vc: UIViewController, with score: Int){
    showBasicAlert(on: vc, with: "Good job", message: "You won with score : \(score)")
  }
  
  static func showFirebaseAlers(on vc: UIViewController){
    showBasicAlert(on: vc, with: "Something going wrong", message: "Unexpected problems with firebase service!")
  }
  
  static func showLocationAlers(on vc: UIViewController){
    showBasicAlert(on: vc, with: "Something going wrong", message: "Unexpected problems with location service!")
  }
  
  static func showWrongAnswerAlert(on vc: UIViewController, with distance: Int){
    showBasicAlert(on: vc, with: "Wrong", message: "City was in \(distance) km from your marker!")
  }
  
  static func showCorrectAnswerAlert(on vc: UIViewController){
    showBasicAlert(on: vc, with: "Great", message: "You got one point!")
  }
}


