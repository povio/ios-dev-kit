//
//  DevKitModifier.swift
//  PovioDevKit
//
//  Created by PovioDevKit on 20/01/2026.
//

import SwiftUI
import Pulse

// MARK: - DevKit View Modifier
/// A view modifier that integrates PovioDevKit with shake-to-open functionality.
struct DevKitViewModifier: ViewModifier {
  let customTools: [CustomTool]
  
  @State private var isPresented = false
  
  func body(content: Content) -> some View {
    content
      .onAppear {
        URLSessionProxyDelegate.enableAutomaticRegistration(logger: .shared)
      }
      .onShake {
        isPresented = true
      }
      .sheet(isPresented: $isPresented) {
        DevKitTabView(customTools: customTools)
      }
  }
}

// MARK: - View Extension
extension View {
  /// Enables PovioDevKit with shake-to-open functionality.
  ///
  /// This modifier:
  /// - Registers network logging automatically
  /// - Listens for shake gestures
  /// - Presents the DevKit console as a sheet
  ///
  /// Usage:
  /// ```swift
  /// @main
  /// struct MyApp: App {
  ///     var body: some Scene {
  ///         WindowGroup {
  ///             ContentView()
  ///                 .withDevKit()
  ///         }
  ///     }
  /// }
  /// ```
  ///
  /// - Parameter customTools: Optional array of custom tools to display in the DevKit.
  /// - Returns: A view with DevKit integration enabled.
  public func withDevKit(customTools: [CustomTool] = []) -> some View {
    self.modifier(DevKitViewModifier(customTools: customTools))
  }
}
