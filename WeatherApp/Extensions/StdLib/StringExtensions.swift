//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit

// MARK: - Styling

let primaryFont = UIFont.systemFont(ofSize: 18)
let secondaryFont = UIFont.systemFont(ofSize: 16)

extension String {
  func applyTemperatureStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self)°c")
      .font(secondaryFont)
      .color(UIColor.black)
  }
  
  func applyRainStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self) mm/1h")
      .font(secondaryFont)
      .color(UIColor.black)
  }
  
  func applyWindStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self) km/h")
      .font(secondaryFont)
      .color(UIColor.black)
  }
  
  func applyPressureStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self) hPa")
      .font(secondaryFont)
      .color(UIColor.black)
  }
  
  func applyHourStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self)h")
      .font(secondaryFont)
      .color(UIColor.black)
  }
  
  func applyNumberStyle() -> NSAttributedString {
    return  NSMutableAttributedString(string: "\(self)")
      .font(secondaryFont)
      .color(UIColor.black)
  }
}
extension String {
  var toDate: Date? {
    return Date(dateString: self)
  }
}
