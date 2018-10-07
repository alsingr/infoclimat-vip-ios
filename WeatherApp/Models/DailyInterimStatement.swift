//
//  DailyInterimStatement.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation


struct DailyInterimStatement: Equatable, Hashable {
  var time: Date
  var temperature: Double
  var rain: Double
  var moisture: Double
  var averageWind: Double
  var pressure: Int
  
  var temperatureInDegreeCelsius: Int {
    return (temperature - 273.15).int
  }
}

extension Array where Element == DailyInterimStatement {
  func minMaxTemperature() -> (min: Int, max: Int)?
  {
    if isEmpty { return nil }
      var currentMin = self[0].temperatureInDegreeCelsius
      var currentMax = self[0].temperatureInDegreeCelsius
    
      for value in self[1..<count] {
        if value.temperatureInDegreeCelsius < currentMin {
          currentMin = value.temperatureInDegreeCelsius
        } else if value.temperatureInDegreeCelsius > currentMax {
          currentMax = value.temperatureInDegreeCelsius
        }
      }
      return (currentMin, currentMax)
  }
}
