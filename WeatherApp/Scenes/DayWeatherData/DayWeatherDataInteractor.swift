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
  var interimStatements: Any? { get set }
}

class DayWeatherDataInteractor: DayWeatherDataBusinessLogic, DayWeatherDataDataStore
{
  var presenter: DayWeatherDataPresentationLogic?
  var worker: DayWeatherDataWorker?
  var interimStatements: Any? = nil
  
  // MARK: FetchDaysWeatherData
  
  func fetchDaysWeatherData(request: DayWeatherData.FetchDaysWeatherData.Request)
  {
    worker = DayWeatherDataWorker()
    worker?.doSomeWork()
    
    let response = DayWeatherData.FetchDaysWeatherData.Response()
    presenter?.presentDaysWeatherData(response: response)
  }
}
