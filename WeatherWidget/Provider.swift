//
//  Provider.swift
//  WeatherWidgetExtension
//
//  Created by bobr on 12/08/2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  let weatherService: WeatherService;
  
  func placeholder(in context: Context) -> WeatherEntry {
    WeatherEntry(date: Date(), configuration: ConfigurationIntent(), weather: WeatherRecord(temperature: 18, condition: "rain"))
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WeatherEntry) -> ()) {
    let entry = WeatherEntry(date: Date(), configuration: configuration, weather: WeatherRecord(temperature: 18, condition: "rain"))
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
    let date = Date()
    
    weatherService.getWeather { record in
      let entry = WeatherEntry(date: date, configuration: configuration, weather: record)
      print(record)
      
      // Create a date that's 15 minutes in the future.
      let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 10, to: date)!
      
      // Create the timeline with the entry and a reload policy with the date
      // for the next update.
      let timeline = Timeline(
        entries: [entry],
        policy: .after(nextUpdateDate)
      )
      
      // Call the completion to pass the timeline to WidgetKit.
      completion(timeline)
    }
  }
  
}

struct WeatherEntry: TimelineEntry {
  var date: Date
  let configuration: ConfigurationIntent
  let weather: WeatherRecord
}
