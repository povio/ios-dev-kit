//
//  CustomTool.swift
//  PovioDevKit
//
//  Created by Yll Fejziu on 07/10/2025.
//

import SwiftUI

public struct CustomTool {
  let title: String
  let icon: String
  let view: AnyView
  
  public init<Content: View>(title: String, icon: String = "star", @ViewBuilder view: () -> Content) {
    self.title = title
    self.icon = icon
    self.view = AnyView(view())
  }
}
