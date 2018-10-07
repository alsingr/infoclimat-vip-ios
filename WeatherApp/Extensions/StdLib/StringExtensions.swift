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
}
extension String {
  var toDate: Date? {
    return Date(dateString: self, timeZone: nil)
  }
}

extension Formatter {
  static func formatToStyle1(_ text: String) -> NSAttributedString
  {
    return NSMutableAttributedString(string: text)
      .font(primaryFont)
      .color(UIColor.black)
  }
  
  static func formatToStyle2(_ text: String) -> NSAttributedString
  {
    return NSMutableAttributedString(string: text)
      .font(secondaryFont)
      .color(UIColor.black)
  }
}
