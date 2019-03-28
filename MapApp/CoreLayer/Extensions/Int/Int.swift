//
//  Int.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation

extension Int {
  func covertToKM() -> Int{
    let concertedDistance = self / 1000
    return concertedDistance
  }
}
