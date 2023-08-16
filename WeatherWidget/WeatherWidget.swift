//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by bobr on 12/08/2023.
//

import WidgetKit
import SwiftUI
import Intents

let weatherService = WeatherService();

@main
struct WeatherWidget: Widget {
  let kind: String = "WeatherWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(weatherService: weatherService)) { entry in
      WeatherWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Yandex Weather")
    .description("Display current weather in your place.")
  }
}
