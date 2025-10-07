//
//  DevKitTabView.swift
//  PovioDevKit
//
//  Created by Yll Fejziu on 20/05/2025.
//

import SwiftUI
import PulseUI
import PulseLogHandler

public struct DevKitTabView: View {
  @Environment(\.presentationMode) private var presentationMode
  let store: LoggerStore
  let customTools: [CustomTool]

  public init(store: LoggerStore, customTools: [CustomTool] = []) {
    self.store = store
    self.customTools = customTools
  }

  public var body: some View {
    NavigationView {
      TabView {
        ToolsListView(store: store, customTools: customTools)
          .tabItem {
            Image(systemName: "wrench")
            Text("Tools")
          }

        Text("⚙️ Settings coming…")
          .tabItem {
            Image(systemName: "gearshape")
            Text("Settings")
          }
      }
      .navigationTitle("PovioDevKit")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(systemName: "xmark")
          }
        }
      }
    }
  }
}
