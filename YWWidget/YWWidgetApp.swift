//
//  YWWidgetApp.swift
//  YWWidget
//
//  Created by bobr on 12/08/2023.
//

import SwiftUI

@main
struct YWWidgetApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView().onOpenURL { url in
        NSWorkspace.shared.open(url)
        NSApplication.shared.window(withWindowNumber: 0)?.close()
        NSApplication.shared.terminate(nil)
      }.frame(maxWidth: 300)
    }
  }
}
