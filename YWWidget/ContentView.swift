//
//  ContentView.swift
//  YWWidget
//
//  Created by bobr on 12/08/2023.
//

import SwiftUI

struct ContentView: View {
  let githubLink = "https://github.com/bobrosoft/macos-yandex-weather-widget"
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Open **Notifications panel** on the top right and add widget from **YWWidget** app.")
      Text("")
      Text("This window can be closed.")
      Text("")
      Text("Author: [Vladimir Tolstikov](https://bobrosoft.com)")
      Text("GitHub: ") + Text("[macos-yandex-weather-widget](\(githubLink))".toMarkdown())
      Text("License: MIT")
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().frame(maxWidth: 300)
  }
}
