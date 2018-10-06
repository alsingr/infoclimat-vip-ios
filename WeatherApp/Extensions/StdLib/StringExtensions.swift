//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation


extension String {
  var toDate: Date? {
    return Date(dateString: self)
  }
}
