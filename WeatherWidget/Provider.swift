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
  func placeholder(in context: Context) -> WeatherEntry {
    WeatherEntry(date: Date(), temperature: 18, condition: "rain", configuration: ConfigurationIntent())
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WeatherEntry) -> ()) {
    let entry = WeatherEntry(date: Date(), temperature: 18, condition: "rain", configuration: configuration)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
    let date = Date()
    let entry = WeatherEntry(date: date, temperature: 18, condition: "rain", configuration: configuration)
    
    // Create a date that's 15 minutes in the future.
    let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!
    
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

struct WeatherEntry: TimelineEntry {
  var date: Date
  
  let temperature: Int
  let condition: String
  let configuration: ConfigurationIntent
}
