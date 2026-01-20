//
//  NetworkFilterConfig.swift
//  PovioDevKit
//
//  Created by PovioDevKit on 20/01/2026.
//

import Foundation

/// Configuration for filtering network requests in Pulse logger.
///
/// Use this to include only specific hosts or exclude noisy requests (e.g., Firebase).
///
/// Example:
/// ```swift
/// let filter = NetworkFilterConfig(
///     includedHosts: ["api.myapp.com"],
///     excludedHosts: ["firebase.googleapis.com"]
/// )
/// ```
public struct NetworkFilterConfig {
  /// Hosts to include in logging. If empty, all hosts are included (unless excluded).
  public var includedHosts: [String]
  
  /// Hosts to exclude from logging (e.g., Firebase, analytics).
  public var excludedHosts: [String]
  
  /// Specific URL patterns to exclude from logging.
  public var excludedURLs: [String]
  
  public init(
    includedHosts: [String] = [],
    excludedHosts: [String] = [],
    excludedURLs: [String] = []
  ) {
    self.includedHosts = includedHosts
    self.excludedHosts = excludedHosts
    self.excludedURLs = excludedURLs
  }
}
