//
//  WeatherForecastsService.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation

enum WeatherForecastsService {
  case within7Days(latitude: Double, longitude: Double)
  
  
  private static let apiKey = "AxkFEgR6VXcEKQE2BXNWfwJqBjMNewgvBHgEZ104VSgDaF8%2BDm5QNgBuUC0DLAs9Ay4HZAA7BTVUP1IqWykEZQNpBWkEb1UyBGsBZAUqVn0CLAZnDS0ILwRuBGNdLlU1A35fOg5sUDAAcVA6AzMLIAMvB2YAOgU%2BVD9SPVs1BGIDYwVkBGNVKAR0AWYFZ1YwAjkGNQ0xCDkENgRqXWVVYwMzX24OaVAsAGlQMgM7CzcDNgdgADsFP1QoUipbTwQUA30FIQQlVWIELQF%2BBWBWPAJl"
  private static let secondKey = "91f0757ee8c5c4be471d6aae881fcc62"
  fileprivate static let baseUrl = URL(string: "http://www.infoclimat.fr/public-api/gfs/json")!
}

extension WeatherForecastsService : ServiceProtocol {
  var baseURL: URL {
    return WeatherForecastsService.baseUrl
  }
  
  var path: String {
    return ""
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var task: Task {
    switch self {
    case .within7Days(let latitude, let longitude):
      let parameters = [
        "_ll": "\(latitude),\(longitude)",
        "_auth": WeatherForecastsService.apiKey.removingPercentEncoding!,
        "_c" : WeatherForecastsService.secondKey.removingPercentEncoding!
      ]
      return .requestParameters(parameters)
    }
  }
  
  var headers: Headers? {
    return ["Content-Type" : "application/x-www-form-urlencoded"]
  }
  
  var parametersEncoding: ParametersEncoding {
    return .url
  }
  
  var supportsRFC3986: Bool {
    return false
  }
  
  
}
