//
//  URLResponse.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import Foundation


extension CachedURLResponse {
  //https://stackoverflow.com/questions/19855280/how-to-set-nsurlrequest-cache-expiration
  func response(withExpirationDuration duration: Int) -> CachedURLResponse {
    var cachedResponse = self
    if let httpResponse = cachedResponse.response as? HTTPURLResponse, var headers = httpResponse.allHeaderFields as? [String : String], let url = httpResponse.url{
      
      headers["Cache-Control"] = "max-age=\(duration)"
      headers.removeValue(forKey: "Expires")
      headers.removeValue(forKey: "s-maxage")
      
      if let newResponse = HTTPURLResponse(url: url, statusCode: httpResponse.statusCode, httpVersion: "HTTP/1.1", headerFields: headers) {
        cachedResponse = CachedURLResponse(response: newResponse, data: cachedResponse.data, userInfo: headers, storagePolicy: cachedResponse.storagePolicy)
      }
    }
    return cachedResponse
  }
}
