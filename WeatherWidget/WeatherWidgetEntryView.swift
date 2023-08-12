//
//  WeatherWidgetEntryView.swift
//  WeatherWidgetExtension
//
//  Created by bobr on 12/08/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct WeatherWidgetEntryView : View {
  var entry: WeatherEntry
  
  var body: some View {
    VStack(alignment: .center, spacing: 5) {
      let sign = entry.temperature < 0 ? "—" : "+"
      
      Text("🌧").font(.system(size: 80))
      Text(sign + String(entry.temperature) + "°C").font(.system(size: 30))
    }
  }
}

struct WeatherWidget_Previews: PreviewProvider {
  static var previews: some View {
    WeatherWidgetEntryView(entry: WeatherEntry(date: Date(), temperature: 18, condition: "rain", configuration: ConfigurationIntent()))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
