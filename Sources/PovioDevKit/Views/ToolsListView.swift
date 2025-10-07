//
//  ToolsListView.swift
//  PovioDevKit
//
//  Created by Yll Fejziu on 20/05/2025.
//

import SwiftUI
import PulseUI
import PulseLogHandler

public struct ToolsListView: View {
  let store: LoggerStore
  let customTools: [CustomTool]
  
  public init(store: LoggerStore, customTools: [CustomTool] = []) {
    self.store = store
    self.customTools = customTools
  }
  
  public var body: some View {
    List {
      networkLoggerRow
      customToolsRows
    }
    .listStyle(InsetGroupedListStyle())
  }
}

// MARK: - Private
private extension ToolsListView {
  var networkLoggerRow: some View {
    NavigationLink(destination: ConsoleView(store: store).closeButtonHidden()) {
      HStack {
        Image(systemName: "network")
          .foregroundColor(.accentColor)
        Text("Pulse Network Logger")
      }
    }
  }
  
  @ViewBuilder
  var customToolsRows: some View {
    ForEach(customTools.indices, id: \.self) { index in
      let tool = customTools[index]
      NavigationLink(destination: tool.view) {
        HStack {
          Image(systemName: tool.icon)
            .foregroundColor(.accentColor)
          Text(tool.title)
        }
      }
    }
  }
}
