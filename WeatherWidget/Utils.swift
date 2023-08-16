//
//  Utils.swift
//  WeatherWidgetExtension
//
//  Created by bobr on 13/08/2023.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue:  Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}

extension String {
  func matchingStrings(regex: String) -> [[String]] {
    guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
    let nsString = self as NSString
    let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
    return results.map { result in
      (0 ..< result.numberOfRanges).map {
        result.range(at: $0).location != NSNotFound
        ? nsString.substring(with: result.range(at: $0))
        : ""
      }
    }
  }
  
  func toLocalDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    dateFormatter.calendar = Calendar(identifier: .gregorian)
    dateFormatter.dateFormat = format
    let date = dateFormatter.date(from: self)
    
    return date
  }
}

extension Array {
  func item(at index: Int) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
