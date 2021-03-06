//
//  DayWeatherDataPresenter.swift
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

protocol DayWeatherDataPresentationLogic
{
  func presentDaysWeatherData(response: DayWeatherData.FetchDaysWeatherData.Response)
}

class DayWeatherDataPresenter: DayWeatherDataPresentationLogic
{
  weak var viewController: DayWeatherDataDisplayLogic?
  
  // MARK: FetchDaysWeatherData
  
  func presentDaysWeatherData(response: DayWeatherData.FetchDaysWeatherData.Response)
  {
    var data = response.daysWeatherData.reduce(into: [DisplayedInterimStatement](), { result, value in
      result.append(DisplayedInterimStatement(interimStatement: value))
    })
    data.insert(DisplayedInterimStatement(), at: 0)
    let viewModel = DayWeatherData.FetchDaysWeatherData.ViewModel(displayedInterimStatements: data)
    viewController?.displayDaysWeatherData(viewModel: viewModel)
  }
}

