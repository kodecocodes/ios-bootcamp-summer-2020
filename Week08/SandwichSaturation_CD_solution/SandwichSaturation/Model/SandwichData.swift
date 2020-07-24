//
//  SandwichData.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

enum SauceAmount: Decodable {
  case any
  case none
  case tooMuch
  
  var description: String {
    switch self {
    case .any:
      return "Any Amount"
    case .none:
      return "Too Dry"
    case .tooMuch:
      return "Drowning in Sauce"
    }
  }
}

struct SandwichData: Decodable {
  let name: String
  let sauceAmount: SauceAmount
  let imageName: String
}

extension SauceAmount: CaseIterable { }

extension SauceAmount: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "Either": self = .any
    case "None": self = .none
    case "Too Much": self = .tooMuch
    default: return nil
    }
  }
  
  var rawValue: String {
    switch self {
    case .any: return "Either"
    case .none: return "None"
    case .tooMuch: return "Too Much"
    }
  }
}

extension SandwichData {
  static func storedSandwiches() -> [SandwichData] {
    guard let url = Bundle.main.url(forResource: "sandwiches", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else { return [] }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode([SandwichData].self, from: data)
    } catch {
      return []
    }
  }
}
