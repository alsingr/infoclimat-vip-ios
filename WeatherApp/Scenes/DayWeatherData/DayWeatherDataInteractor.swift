//
//  DayWeatherDataInteractor.swift
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

protocol DayWeatherDataBusinessLogic
{
  func fetchDaysWeatherData(request: DayWeatherData.FetchDaysWeatherData.Request)
}

protocol DayWeatherDataDataStore
{
  var interimStatements: [DailyInterimStatement]? { get set }
}

class DayWeatherDataInteractor: DayWeatherDataBusinessLogic, DayWeatherDataDataStore
{
  var presenter: DayWeatherDataPresentationLogic?
  var worker: DayWeatherDataWorker?
  var interimStatements: [DailyInterimStatement]? = nil
  
  // MARK: FetchDaysWeatherData
  
  func fetchDaysWeatherData(request: DayWeatherData.FetchDaysWeatherData.Request)
  {
    if let data = self.interimStatements {
      let response = DayWeatherData.FetchDaysWeatherData.Response(daysWeatherData: data)
      presenter?.presentDaysWeatherData(response: response)
    }

  }
}
