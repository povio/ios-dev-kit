//
//  ShakeGesture.swift
//  PovioDevKit
//
//  Created by PovioDevKit on 20/01/2026.
//

import SwiftUI
import UIKit

// MARK: - Shake Notification
extension UIDevice {
  /// Notification posted when a shake gesture is detected.
  public static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

// MARK: - UIWindow Motion Override
extension UIWindow {
  /// Override the default behavior of shake gestures to post our notification.
  override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
    }
  }
}

// MARK: - View Modifier
/// A view modifier that detects device shake gestures and calls an action.
public struct DeviceShakeViewModifier: ViewModifier {
  let action: () -> Void
  
  public func body(content: Content) -> some View {
    content
      .onAppear()
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
        action()
      }
  }
}

// MARK: - View Extension
extension View {
  /// Performs an action when the device is shaken.
  /// - Parameter action: The closure to execute when a shake gesture is detected.
  /// - Returns: A view that triggers the action on shake.
  public func onShake(perform action: @escaping () -> Void) -> some View {
    self.modifier(DeviceShakeViewModifier(action: action))
  }
}
