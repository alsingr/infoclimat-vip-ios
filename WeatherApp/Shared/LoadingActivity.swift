//
//  LoadingActivity.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit

class LoadingActivity {
  // MARK: - Properties
  private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .whiteLarge)
  private var loadingView:UIView = UIView()
  private var color:UIColor? = nil
  private(set) var loaderIsAnimating: Bool = false
  static var shared = LoadingActivity()
  
  private init(color:UIColor = UIColor.black.withAlphaComponent(0.4) )
  {
    self.color = color
  }
  
  func startAnimating()
  {
    guard loaderIsAnimating == false else { return }
    let mainView = UIApplication.shared.delegate?.window??.rootViewController?.view
    self.loadingView = UIView.init(frame: mainView!.bounds)
    self.activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
    self.loadingView.backgroundColor = self.color
    self.activityIndicator.startAnimating()
    self.activityIndicator.center = self.loadingView.center
    self.loadingView.addSubview(self.activityIndicator)
    mainView!.addSubview(self.loadingView)
    self.loadingView.center = mainView!.center
    self.activityIndicator.center = self.loadingView.center
    self.loaderIsAnimating = true
    
  }
  
  func stopAnimating()
  {
    guard loaderIsAnimating == true else { return }
    self.loaderIsAnimating = false
    self.activityIndicator.stopAnimating()
    self.loadingView.removeFromSuperview()
  }
}
