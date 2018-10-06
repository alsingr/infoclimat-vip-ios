//
//  DataExtensions.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 06/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation

public extension Data {
  
  /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
  ///
  /// - Parameter encoding: encoding.
  /// - Returns: String by encoding Data using the given encoding (if applicable).
  public func string(encoding: String.Encoding) -> String? {
    return String(data: self, encoding: encoding)
  }
  
  public func mapJSON() -> [String:AnyObject]? {
    return (try? JSONSerialization.jsonObject(with: self, options: .mutableContainers)) as? [String : AnyObject]
  }
  
}
