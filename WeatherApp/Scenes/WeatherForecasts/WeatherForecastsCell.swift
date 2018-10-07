//
//  WeatherForecastsCell.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit


class WeatherForecastsCell: UITableViewCell {
  @IBOutlet weak var dayAndMonthL: UILabel!
  @IBOutlet weak var presentationL: UILabel!
  
  var daysWeatherData: WeatherForecasts.FetchWeatherData.ViewModel.DaysWeatherData? {
    didSet {
      self.updateUI()
    }
  }
  
  private func updateUI()
  {
    let description = daysWeatherData?.date.applyDateStyle().addLine()
    description?.append("\(daysWeatherData?.minTemperature ?? 0 )".applyTemperatureStyle())
    description?.append("/\(daysWeatherData?.maxTemperature ?? 0 )".applyTemperatureStyle())
    textLabel?.attributedText = description
  }
  
}
