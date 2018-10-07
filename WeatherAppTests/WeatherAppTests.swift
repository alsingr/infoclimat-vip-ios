//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import XCTest
@testable import WeatherApp
class WeatherAppTests: XCTestCase {
  var dailyInterimStatement1: DailyInterimStatement!
  var displayedInterimStatement: DisplayedInterimStatement!
  var daysWeatherData: [DailyInterimStatement]!
  
  override func setUp() {
    super.setUp()
    setupVariables()
  }
  
  func setupVariables()
  {
    self.dailyInterimStatement1 = DailyInterimStatement(time: Date(dateString: "2018-10-15 05:00:00", timeZone: nil)!, temperature: 288.6, rain: 1.9, moisture: 83.4 , averageWind: 7.5, pressure: 101310)
    self.displayedInterimStatement = DisplayedInterimStatement(interimStatement: self.dailyInterimStatement1)
    self.daysWeatherData = [DailyInterimStatement(time: "2018-10-09 00:00:00".toDate!, temperature: 285.2, rain: 0.0, moisture: 62.4, averageWind: 6.8, pressure: 102130), DailyInterimStatement(time: "2018-10-09 03:00:00".toDate!, temperature: 284.3, rain: 0.0, moisture: 68.3, averageWind: 4.2, pressure: 102020), DailyInterimStatement(time: "2018-10-09 06:00:00".toDate!, temperature: 284.5, rain: 0.0, moisture: 74.6, averageWind: 5.3, pressure: 102030), DailyInterimStatement(time: "2018-10-09 09:00:00".toDate!, temperature: 289.0, rain: 0.0, moisture: 64.2, averageWind: 5.6, pressure: 102090), DailyInterimStatement(time: "2018-10-09 12:00:00".toDate!, temperature: 294.0, rain: 0.0, moisture: 52.2, averageWind: 7.0, pressure: 101970), DailyInterimStatement(time: "2018-10-09 15:00:00".toDate!, temperature: 295.9, rain: 0.0, moisture: 46.8, averageWind: 7.4, pressure: 101780), DailyInterimStatement(time: "2018-10-09 18:00:00".toDate!, temperature: 291.8, rain: 0.0, moisture: 62.2, averageWind: 8.2, pressure: 101750), DailyInterimStatement(time: "2018-10-09 21:00:00".toDate!, temperature: 289.9, rain: 0.0, moisture: 71.8, averageWind: 7.8, pressure: 101830)]
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    resetVariables()
    super.tearDown()
  }
  
  func resetVariables()
  {
    daysWeatherData = []
    dailyInterimStatement1 = nil
    displayedInterimStatement = nil
  }
  
  func testTemperatureInDegreeCelcius() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(dailyInterimStatement1.temperatureInDegreeCelsius, 15)
  }
  
  func testDailyInterimStatementStringValues() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(displayedInterimStatement.temperature, "15°c")
    XCTAssertEqual(displayedInterimStatement.averageWind, "7.5 km/h")
    XCTAssertEqual(displayedInterimStatement.rain, "1.9 mm/1h")
    XCTAssertEqual(displayedInterimStatement.pressure, "101310 hPa")
    XCTAssertEqual(displayedInterimStatement.moisture, "83.4%")
    XCTAssertEqual(displayedInterimStatement.time, "5h")
  }
  
  func testMinMaxTemperature() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let maxMin = daysWeatherData.minMaxTemperature()
    XCTAssertEqual(maxMin?.min, 11)
    XCTAssertEqual(maxMin?.max, 22)
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
