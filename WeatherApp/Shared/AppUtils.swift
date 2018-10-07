//
//  AppUtils.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit

class AppUtils {
  public static var mostTopViewController: UIViewController? {
    get {
      return UIApplication.shared.keyWindow?.rootViewController
    }
    set {
      UIApplication.shared.keyWindow?.rootViewController = newValue
    }
  }
}
