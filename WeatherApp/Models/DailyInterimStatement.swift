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
  var temperature: Int
  var rain: Double
  var moisture: Double
  var averageWind: Double
  var pressure: Int
}
