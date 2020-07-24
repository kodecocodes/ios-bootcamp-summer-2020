//
//  SauceAmountModel+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/9/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData

// This file is only generated if it doesn't already exist
@objc(SauceAmountModel)
public class SauceAmountModel: NSManagedObject {
  var sauceAmount: SauceAmount {
    get {
      guard let sauceAmountString = self.sauceAmountString,
        let amount = SauceAmount(rawValue: sauceAmountString)
        else { return .none }
      
      return amount
    }
    
    set {
      self.sauceAmountString = newValue.rawValue
    }
  }
}
