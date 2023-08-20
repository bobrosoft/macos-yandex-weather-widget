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
  
  let iconsSourceDay = [
    "clear": "☀️",
    "mostly-clear": "🌤",
    "partly-cloudy": "⛅️",
    "overcast": "☁️",
    "cloudy": "☁️",
    "light-rain": "🌦",
    "drizzle": "💦",
    "rain": "🌧",
    "heavy-rain": "⛈",
    "storm": "🌩",
    "thunderstorm-with-rain": "⛈",
    "sleet": "☔️",
    "light-snow": "❄️",
    "snow": "🌨",
    "fog": "😶‍🌫️",
  ]
  let iconsSourceNight = [
    "clear": "🌙",
  ]
  
  let stars: [Star] = [
    Star(x: 100, y: 100, size: 1),
    Star(x: 130, y: 110, size: 2),
    Star(x: 190, y: 96, size: 2),
    Star(x: 230, y: 130, size: 1),
    Star(x: 113, y: 140, size: 1),
    Star(x: 215, y: 120, size: 1),
  ]
  
  var hour: Int {
    get {
      return Calendar.current.component(.hour, from: entry.date)
    }
  }
  
  var isEvening: Bool {
    get {
      return hour >= 17 && hour < 20
    }
  }
  
  var isNight: Bool {
    get {
      return hour >= 20 || hour < 7
    }
  }
  
  var conditionText: String {
    guard let condition = entry.weather.condition else {
      return "⏳"
    }
    
    return (isNight && (iconsSourceNight[condition] != nil) ? iconsSourceNight[condition]! : iconsSourceDay[condition] ?? condition)
  }
  
  var body: some View {
    let weather = entry.weather
    let sign = (weather.temperature ?? 0) < 0 ? "—" : "+"
    
    let colors: [Color] = isNight ? [Color(hex: "#000b38"), Color(hex: "#143791")] : (isEvening ? [Color(hex: "#3C1151"), Color(hex: "#863265"), Color(hex: "#D1968D")] : [Color(hex: "#3478E5"), Color(hex: "#8CD2FA")])
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
    
    ZStack {
      backgroundGradient
      
      if (isNight || isEvening) {
        ForEach(stars) {star in
          Circle().size(CGSize(width: CGFloat(star.size), height: CGFloat(star.size))).position(x: CGFloat(star.x), y: CGFloat(star.y)).colorInvert()
        }
      }
      
      VStack(alignment: .center, spacing: 0) {
        Text(conditionText).font(.system(size: 80))
        Text((weather.temperature != nil ? sign + String(weather.temperature!) + "°C" : "???")).font(.system(size: 30, weight:
            .medium)).colorInvert()
        Spacer().frame(height: 4)
      }
    }
  }
}

struct WeatherWidgetEntryView_Previews: PreviewProvider {
  static var previews: some View {
    WeatherWidgetEntryView(entry: WeatherEntry(date: "2015-04-01 10:42:00".toLocalDate()!, configuration: ConfigurationIntent(), weather: WeatherRecord(temperature: 18, condition: "clear")))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      .previewDisplayName("Day")
    
    WeatherWidgetEntryView(entry: WeatherEntry(date: "2015-04-01 17:42:00".toLocalDate()!, configuration: ConfigurationIntent(), weather: WeatherRecord(temperature: 19, condition: "rain")))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      .previewDisplayName("Evening")
    
    WeatherWidgetEntryView(entry: WeatherEntry(date: "2015-04-01 23:42:00".toLocalDate()!, configuration: ConfigurationIntent(), weather: WeatherRecord(temperature: 16, condition: "overcast")))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      .previewDisplayName("Night")
    
    WeatherWidgetEntryView(entry: WeatherEntry(date: "2015-04-01 10:42:00".toLocalDate()!, configuration: ConfigurationIntent(), weather: WeatherRecord(temperature: nil, condition: nil)))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
      .previewDisplayName("No data")
  }
}

struct Star: Identifiable {
  let x: Float
  let y: Float
  let size: Float
  
  var id: String {
    get {
      return String(x) + String(y) + String(size)
    }
  }
}
