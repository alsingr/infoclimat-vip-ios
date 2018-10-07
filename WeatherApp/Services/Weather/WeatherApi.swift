//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherApi: WeatherStoreProtocol {
  private let sessionProvider: URLSessionProvider
  init(sessionProvider: URLSessionProvider = URLSessionProvider(usingCache:true)) {
    self.sessionProvider = sessionProvider
  }
  
  func fetchForecasts(location: CLLocation, completionHandler: @escaping (() throws -> [Date : [DailyInterimStatement]]) -> Void) {
    sessionProvider.request(service: WeatherForecastsService.within7Days(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)) { response in
      switch response {
      case let .success(fullJsonObject):
        do {
          let object = try self.extractFlatMeteoValuesFrom(fullJsonObject)
          completionHandler { return object }
        }
        catch {
          completionHandler { throw error }
        }
      case let .failure(error):
        completionHandler { throw error }
        
      }
    }
    
  }
  private func extractFlatMeteoValuesFrom(_ apiResponse: [String: AnyObject]) throws -> [Date : [DailyInterimStatement]] {
    let keysWithDateString = apiResponse.keys.filter({$0.toDate != nil})
    guard keysWithDateString.isEmpty == false else { throw NetworkError.noJSONData }
    
    return try keysWithDateString.reduce(into: [Date:[DailyInterimStatement]]()) { result, key in
      guard
        let dateKey = key.toDate,
        let apiResponseForCurrentKey = apiResponse[key] as? [String : AnyObject]
        else { throw NetworkError.noJSONData }
      
      let dailyStatement = try mapDailyStatementModel(in:apiResponseForCurrentKey, withKey: dateKey)
      
      let dateKeyWithoutHoursAndMinutes = Date(timeZone: nil, year: dateKey.year, month: dateKey.month, day: dateKey.day, hour: 0, minute: 0, second: 0)!
      
      var orderedArray = result[dateKeyWithoutHoursAndMinutes]
      if orderedArray != nil {
        orderedArray!.append(dailyStatement)
        orderedArray = orderedArray!.sorted(by: { value1, value2 in return value1.time < value2.time })
         result[dateKeyWithoutHoursAndMinutes] = orderedArray
      } else {
        result[dateKeyWithoutHoursAndMinutes] = [dailyStatement]
      }
      
    }
  }
  
  private func mapDailyStatementModel(in dailyDataSingleValue: [String : AnyObject], withKey dateKey: Date) throws -> DailyInterimStatement
  {
    guard
      let rain = dailyDataSingleValue["pluie"] as? Double,
      let temperature = dailyDataSingleValue["temperature"]?["2m"] as? Double,
      let averageWind = dailyDataSingleValue["vent_moyen"]?["10m"] as? Double,
      let moisture = dailyDataSingleValue["humidite"]?["2m"] as? Double,
      let pressure = dailyDataSingleValue["pression"]?["niveau_de_la_mer"] as? Int
    else { throw NetworkError.noJSONData }
    
    return DailyInterimStatement(
      time: dateKey,
      temperature: temperature,
      rain: rain,
      moisture: moisture,
      averageWind: averageWind,
      pressure: pressure
    )
  }
  
}
