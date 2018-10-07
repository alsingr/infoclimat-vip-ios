//
//  WeatherWorker.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherWorker {
  enum Defaults {
    public static var location: CLLocation {
      return CLLocation(latitude:48.85341 , longitude: 2.3488)
    }

  }
  
  var weatherDataStore: WeatherStoreProtocol
  
  init(weatherDataStore: WeatherStoreProtocol)
  {
    self.weatherDataStore = weatherDataStore
  }
  
  func fetchWeatherForecasts(location: CLLocation = WeatherWorker.Defaults.location, completionHandler: @escaping ([Date : [DailyInterimStatement]]) -> Void)
  {
    weatherDataStore.fetchForecasts(location: location) { (weatherData: () throws -> [Date : [DailyInterimStatement]]) -> Void in
      do {
        let weatherForecasts = try weatherData()
        DispatchQueue.main.async {
          completionHandler(weatherForecasts)
        }
      } catch {
        DispatchQueue.main.async {
          completionHandler([:])
        }
      }
    }
  }
}


// MARK: - Weather store API
protocol WeatherStoreProtocol
{
  // MARK: CRUD operations - Inner closure
  func fetchForecasts(location: CLLocation, completionHandler: @escaping (() throws -> [Date : [DailyInterimStatement]]) -> Void)
}
