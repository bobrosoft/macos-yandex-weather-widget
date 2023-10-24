//
//  WeatherService.swift
//  WeatherWidgetExtension
//
//  Created by bobr on 15/08/2023.
//

import Cocoa
import CoreLocation

class WeatherService: NSObject, CLLocationManagerDelegate {
  private var location: CLLocation?
  private var manager: CLLocationManager!
  private var updateWeatherTask: URLSessionDataTask?
  
  override init() {
    super.init()
    
    manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    manager.startMonitoringSignificantLocationChanges()
  }
  
  func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    location = locations.last
  }
  
  func getLocation() -> CLLocation? {
    return location;
  }
  
  func getWeather(completion: @escaping (WeatherRecord) -> ()) {
    var urlRequest = URLRequest(url: URL(string: getWeatherUrl())!)
    urlRequest.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36", forHTTPHeaderField: "user-agent") // important for the right format
    
    updateWeatherTask?.cancel()
    updateWeatherTask = URLSession.shared.dataTask(with: urlRequest) {data, _, error in
      guard error == nil, let data = data else {
        return
      }
      
      let response = String(decoding: data, as: UTF8.self)
//      print(response)
      
      var matches: [[String]]
      var temperature: String
      matches = response.matchingStrings(regex: "fact__temp.*?temp__value.*?>(.*?)<")
      temperature = (matches.first?.item(at: 1) ?? "")
        .replacingOccurrences(of: "−", with: "-") // need to replace "long minus" with "short minus" for proper conversion
      
      var condition: String?
//      matches = response.matchingStrings(regex: "\"condition\":\"(.*?)\"") // old parser
      matches = response.matchingStrings(regex: "link__condition.*?>(.*?)<")
      condition = matches.first?.item(at: 1)?.lowercased().replacingOccurrences(of: " ", with: "-")
      
      let record = WeatherRecord(temperature: Int(temperature), condition: condition)
      completion(record)
    }
    
    updateWeatherTask?.resume()
  }
  
  func getWeatherUrl() -> String {
    if let location = location {
      return "https://meteum.ai/?lang=en&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
    } else {
      return "https://meteum.ai/?lang=en" // Yandex will try to determine your location by default
    }
  }
}

struct WeatherRecord {
  let temperature: Int?
  let condition: String?
}
