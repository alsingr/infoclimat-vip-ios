//
//  DayWeatherCell.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {
  
  @IBOutlet weak var timeL: UILabel!
  @IBOutlet weak var temperatureL: UILabel!
  @IBOutlet weak var rainL: UILabel!
  @IBOutlet weak var moistureL: UILabel!
  @IBOutlet weak var averageWindL: UILabel!
  @IBOutlet weak var pressureL: UILabel!
  
  var daysWeatherDetailsData: DayWeatherData.FetchDaysWeatherData.ViewModel.DisplayedInterimStatement? {
    didSet {
      self.updateUI()
    }
  }
  
  private func updateUI()
  {
    timeL.attributedText = daysWeatherDetailsData?.time
    temperatureL.attributedText = daysWeatherDetailsData?.temperature
    rainL.attributedText = daysWeatherDetailsData?.rain
    moistureL.attributedText = daysWeatherDetailsData?.moisture
    averageWindL.attributedText = daysWeatherDetailsData?.averageWind
    pressureL.attributedText = daysWeatherDetailsData?.pressure
  }
  
}
