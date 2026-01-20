# PovioDevKit

**An in-app debug toolkit for iOS**  
Shake to reveal a customizable Tab-view of tools—starting with a full [Pulse](https://github.com/kean/Pulse)-powered Network Logger.  

[![SPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](#installation)  
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## Features

- **Shake-to-open** debug console (no boilerplate window subclass or SceneDelegate changes).  
- **Pulse** integration for logging and network inspection—all your `URLSession` (and Alamofire/OpenAPI) calls show up.  
- **TabView** architecture—add new tools (feature toggles, performance monitors, etc.) alongside “Network.”  
- **Swift Package Manager** delivery—drop it in and go.

---

## 📦 Installation

1. In Xcode go to **File → Swift Packages → Add Package Dependency…**  
2. Enter `https://github.com/poviolabs/ios-dev-kit.git`  
3. Choose a version (e.g. `Up to Next Major` `1.0.0`).

---

## 🚀 Quick Start

### Option A: SwiftUI Setup (Recommended)

The simplest way to integrate PovioDevKit in a SwiftUI app is with a single modifier:

```swift
import SwiftUI
import PovioDevKit

@main
struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        #if !PRODUCTION
        .withDevKit()
        #endif
    }
  }
}
```

That's it! The `.withDevKit()` modifier:
- Registers network logging automatically
- Listens for shake gestures
- Presents the DevKit console as a sheet

#### Custom Tools

Pass custom tools to add your own debug views:

```swift
.withDevKit(customTools: [
  CustomTool(title: "Feature Flags", icon: "flag") {
    FeatureFlagsView()
  }
])
```

#### Manual Control (Alternative)

For more control over presentation, use the `.onShake` modifier directly:

```swift
import SwiftUI
import PovioDevKit
import Pulse

@main
struct MyApp: App {
  @State private var showDevKit = false
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        #if !PRODUCTION
        .onShake { showDevKit = true }
        .sheet(isPresented: $showDevKit) {
          DevKitTabView()
        }
        .onAppear {
          URLSessionProxyDelegate.enableAutomaticRegistration(logger: .shared)
        }
        #endif
    }
  }
}
```

---

### Option B: UIKit / AppDelegate Setup

```swift
import UIKit
import PovioDevKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Kick off logging, network proxy & shake trigger
    PovioDevKit.shared.start()
    return true
  }
}
