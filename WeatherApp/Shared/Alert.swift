//
//  Alert.swift
//  WeatherApp
//
//  Created by Alvyn SILOU on 07/10/2018.
//  Copyright © 2018 Alvyn SILOU. All rights reserved.
//

import UIKit


public let okString = "OK"
public let cancelString = "Annuler"
public let errorOccuredString = "Erreur"



public protocol AlertActionType: Hashable, CaseIterable {
  var style: UIAlertAction.Style { get }
}

public protocol AlertAction {
  associatedtype AType: AlertActionType
  func titie(for type: AType) -> String
}

public struct Alert {
  private init() {}
  
  public struct OkAction: AlertAction {
    public let okTitle: String
    
    init(okTitle: String = okString) {
      self.okTitle = okTitle
    }
    
    public func titie(for type: ActionType) -> String {
      switch type {
      case .ok: return okTitle
      }
    }
    
    public enum ActionType: String, AlertActionType {
      case ok
      
      public static var values: [ActionType] {
        return [.ok]
      }
      public var style: UIAlertAction.Style {
        switch self {
        case .ok: return .default
        }
      }
    }
  }
  
  public struct OkCancelAction: AlertAction {
    public let okTitle: String
    public let cancelTitle: String
    
    init(okTitle: String = okString, cancelTitle: String = cancelString) {
      self.okTitle = okTitle
      self.cancelTitle = cancelTitle
    }
    
    public func titie(for type: ActionType) -> String {
      switch type {
      case .ok: return okTitle
      case .cancel: return cancelTitle
      }
    }
    
    public enum ActionType: String, AlertActionType {
      case
      ok,
      cancel
      
      public static var values: [ActionType] {
        return [.ok, .cancel]
      }
      
      public var style: UIAlertAction.Style {
        switch self {
        case .ok: return .default
        case .cancel: return .cancel
        }
      }
    }
  }
}

public protocol Alertable {
  func prompt<Action: AlertAction>(title: String?, message: String?, action: Action, preferredStyle: UIAlertController.Style, handleAction: @escaping (Action.AType) -> Void)
  func prompt(title: String?, message: String?, okTitle: String, didTap: (() -> ())?)
  func promptWithCancel(title: String?, message: String?, okTitle: String, cancelTitle: String, didTap: (() -> ())?)
  func prompt(error message: String?, didTap: (() -> ())?)
  
}



extension Alertable where Self: UIViewController {
  
  public func prompt<Action: AlertAction>(title: String?, message: String?, action: Action, preferredStyle: UIAlertController.Style = .alert, handleAction: @escaping (Action.AType) -> Void) {
    let alertView = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    for type in Action.AType.allCases {
      alertView.addAction(UIAlertAction(title: action.titie(for: type), style: type.style) { _ in
        handleAction(type)
      })
    }
    
    if let presentedFromVC = AppUtils.mostTopViewController {
      presentedFromVC.present(alertView, animated: true, completion: nil)
    }else {
      self.present(alertView, animated: true, completion: nil)
    }
    
    //      return Disposables.create {
    //        alertView.dismiss(animated:false, completion: nil)
    //      }
  }
  
  public func prompt(title: String?, message: String?, okTitle: String = okString, didTap: (() -> ())? = {}) {
    prompt(title: title, message: message, action: Alert.OkAction(okTitle: okTitle)) { type in
      didTap?()
    }
  }
  
  public func promptWithCancel(title: String?,
                               message: String?,
                               okTitle: String = okString,
                               cancelTitle: String = cancelString,
                               didTap: (() -> ())? = {}) {
    prompt(title: title,
           message: message,
           action: Alert.OkCancelAction(okTitle: okTitle, cancelTitle: cancelTitle)) { type in
            switch type {
            case .ok:
              didTap?()
            case .cancel:
              break
            }
    }
  }
  
  public func prompt(error message: String?, didTap: (() -> ())? = {}) {
    prompt(title: errorOccuredString, message: message)
  }
}



