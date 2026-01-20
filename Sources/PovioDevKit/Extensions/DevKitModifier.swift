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
  let networkFilter: NetworkFilterConfig?
  
  @State private var isPresented = false
  
  func body(content: Content) -> some View {
    content
      .onAppear {
        URLSessionProxyDelegate.enableAutomaticRegistration(logger: createNetworkLogger())
      }
      .onShake {
        isPresented = true
      }
      .sheet(isPresented: $isPresented) {
        DevKitTabView(customTools: customTools)
      }
  }
  
  private func createNetworkLogger() -> NetworkLogger {
    NetworkLogger { config in
      if let filter = networkFilter {
        if !filter.includedHosts.isEmpty {
          config.includedHosts = Set(filter.includedHosts)
        }
        if !filter.excludedHosts.isEmpty {
          config.excludedHosts = Set(filter.excludedHosts)
        }
        if !filter.excludedURLs.isEmpty {
          config.excludedURLs = Set(filter.excludedURLs)
        }
      }
    }
  }
}

// MARK: - View Extension
extension View {
  /// Enables PovioDevKit with shake-to-open functionality.
  ///
  /// This modifier:
  /// - Registers network logging automatically with optional filtering
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
  ///                 .withDevKit(
  ///                     networkFilter: NetworkFilterConfig(
  ///                         excludedHosts: ["firebase.googleapis.com"]
  ///                     )
  ///                 )
  ///         }
  ///     }
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - customTools: Optional array of custom tools to display in the DevKit.
  ///   - networkFilter: Optional filter configuration for network logging.
  /// - Returns: A view with DevKit integration enabled.
  public func withDevKit(
    customTools: [CustomTool] = [],
    networkFilter: NetworkFilterConfig? = nil
  ) -> some View {
    self.modifier(DevKitViewModifier(customTools: customTools, networkFilter: networkFilter))
  }
}
