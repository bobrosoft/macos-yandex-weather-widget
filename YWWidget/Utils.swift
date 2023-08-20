//
//  Utils.swift
//  YWWidget
//
//  Created by bobr on 17/08/2023.
//

import Foundation

extension String {
  func toMarkdown() -> AttributedString {
    do {
      return try AttributedString(markdown: self)
    } catch {
      print("Error parsing Markdown for string \(self): \(error)")
      return AttributedString(self)
    }
  }
}
