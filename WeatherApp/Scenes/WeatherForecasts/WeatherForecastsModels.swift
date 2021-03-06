//
//  WeatherForecastsModels.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright (c) 2018 Alvyn SILOU. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum WeatherForecasts
{
  // MARK: Use cases
  
  enum FetchWeatherData
  {
    struct Request
    {
    }
    
    struct Response
    {
      var interimStatements: [Date: [DailyInterimStatement]]
    }
    
    struct ViewModel
    {
      struct DaysWeatherData {
        let date: Date
        let minTemperature: Int
        let maxTemperature: Int
      }
      
      let weatherData: [DaysWeatherData]
    }
  }
  
  enum ShowDetails
  {
    struct Request
    {
      let date: Date
    }
    
    struct Response
    {
    }
    
    struct ViewModel
    {
    }
  }
}
