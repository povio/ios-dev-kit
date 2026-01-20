//
//  Trigger.swift
//  PovioDevKit
//
//  Created by Yll Fejziu on 20/05/2025.
//

import UIKit

@MainActor
public protocol Trigger {
  func subscribe(on event: @escaping () -> Void)
}

@MainActor
public struct ShakeTrigger: Trigger {
  public init() {}
  
  public func subscribe(on event: @escaping () -> Void) {
    MotionInterceptor.shared.onShake = event
    MotionInterceptor.shared.enable()
  }
}

@MainActor
private final class MotionInterceptor {
  static let shared = MotionInterceptor()
  var onShake: (() -> Void)?
  private var didSwizzle = false
  
  func enable() {
    guard !didSwizzle else { return }
    didSwizzle = true
    
    let uiApp = UIApplication.self
    let original = #selector(UIApplication.motionEnded(_:with:))
    let swizzled = #selector(UIApplication.povio_motionEnded(_:with:))
    
    guard let origMethod = class_getInstanceMethod(uiApp, original),
          let swizMethod = class_getInstanceMethod(uiApp, swizzled) else { return }
    
    method_exchangeImplementations(origMethod, swizMethod)
  }
}

extension UIApplication {
  @objc func povio_motionEnded(_ motion: UIEvent.EventSubtype,
                               with event: UIEvent?) {
    self.povio_motionEnded(motion, with: event)
    
    if motion == .motionShake {
      MotionInterceptor.shared.onShake?()
    }
  }
}
