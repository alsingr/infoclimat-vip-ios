//
//  WeatherForecastsViewController.swift
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

protocol WeatherForecastsDisplayLogic: class
{
  func displayWeatherForecasts(viewModel: WeatherForecasts.FetchWeatherData.ViewModel)
}

class WeatherForecastsViewController: UITableViewController, WeatherForecastsDisplayLogic
{
  var interactor: WeatherForecastsBusinessLogic?
  var router: (NSObjectProtocol & WeatherForecastsRoutingLogic & WeatherForecastsDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = WeatherForecastsInteractor()
    let presenter = WeatherForecastsPresenter()
    let router = WeatherForecastsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    fetchWeatherData()
  }
  
  // MARK: FetchWeatherData
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func fetchWeatherData()
  {
    let request = WeatherForecasts.FetchWeatherData.Request()
    interactor?.fetchWeatherForecasts(request: request)
  }
  
  func displayWeatherForecasts(viewModel: WeatherForecasts.FetchWeatherData.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
