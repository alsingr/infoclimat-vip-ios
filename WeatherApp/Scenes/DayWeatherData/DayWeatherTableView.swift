//
//  DayWeatherTableView.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit


extension DayWeatherDataViewController : UITableViewDelegate, UITableViewDataSource{
  
  // MARK: - Table View
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayedInterimStatements.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! DayWeatherCell
    cell.daysWeatherDetailsData = displayedInterimStatements[indexPath.row]
    return cell
  }
 
  
}

