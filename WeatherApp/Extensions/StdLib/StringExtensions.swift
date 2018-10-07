//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit

// MARK: - Styling

extension String {
  func applyTemperatureStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self)°c")
      .font(UIFont.systemFont(ofSize: 16))
      .color(UIColor.black)
  }
  
}
extension String {
  var toDate: Date? {
    return Date(dateString: self)
  }
}
