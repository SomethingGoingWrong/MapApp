//
//  BaseView.swift
//  MapApp
//
//  Created by Назар on 3/28/19.
//  Copyright © 2019 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BaseView: UIView{
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.configure()
  }
  
  func configure(){
    
  }
}
