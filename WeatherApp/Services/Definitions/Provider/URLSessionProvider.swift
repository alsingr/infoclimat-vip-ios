//
//  URLSessionProvider.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {
  
  private var session: URLSessionProtocol
  private lazy var cachedSession: URLSession = {
    URLCache.shared.memoryCapacity = 512 * 1024 * 1024
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataDontLoad
    return URLSession(configuration: configuration)
  }()
  
  init(usingCache: Bool = false, session: URLSessionProtocol = URLSession.shared, sessionDelegate: URLSessionDataDelegate = ProviderSessionDelegate()) {
    self.session = session
    if usingCache {
      self.session = cachedSession
    }
  }
  
  func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
    let request = URLRequest(service: service)
    
    let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
      let httpResponse = response as? HTTPURLResponse
      self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
    })
    task.resume()
  }
  
  func request(service: ServiceProtocol, completion: @escaping (NetworkResponse<[String:AnyObject]>) -> ()) {
    let request = URLRequest(service: service)
    
    let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
      let httpResponse = response as? HTTPURLResponse
      self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
    })
    task.resume()
  }
  
  private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
    
    guard error == nil else { return completion(.failure(.unknown)) }
    guard let response = response else { return completion(.failure(.noJSONData)) }
    
    switch response.statusCode {
    case 200...299:
      guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.unknown)) }
      completion(.success(model))
    default:
      completion(.failure(.unknown))
    }
  }
  
  private func handleDataResponse(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<[String : AnyObject]>) -> ()) {
    guard error == nil else { return completion(.failure(.unknown)) }
    guard let response = response else { return completion(.failure(.noJSONData)) }
    switch response.statusCode {
    case 200...299:
      guard let data = data, let model = data.mapJSON()
        else { return completion(.failure(.unknown)) }
      completion(.success(model))
    default:
      completion(.failure(.unknown))
    }
  }
  
  
}

class ProviderSessionDelegate: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
    if dataTask.currentRequest?.cachePolicy == .useProtocolCachePolicy {
      let newResponse = proposedResponse.response(withExpirationDuration: 300)
      completionHandler(newResponse)
    }else {
      completionHandler(proposedResponse)
    }
  }
  
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: (URLSession.ResponseDisposition) -> Void) {
    completionHandler(.allow)
  }

}


