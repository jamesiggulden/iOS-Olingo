//
//  IsEmptyTestable.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 30/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation


/// Protocol to extend the functionality of optional types to handle check 
/// for nil and empty in a single method call without the need to explicitly unwrap
/// originally sourced from [here](https://palpatim.wordpress.com/2016/05/30/testing-for-isempty-with-swift-optionals/)
protocol IsEmptyTestable {
  var isEmpty: Bool { get }
}

/// Extension of `IsEmptyTestable` protocol to extend the functionality of optional types to handle check
/// for nil and empty in a single method call without the need to explicitly unwrap
extension Optional where Wrapped: IsEmptyTestable {
  /// `true` if the Wrapped value is `nil`,
  /// otherwise returns `wrapped.isEmpty`
  var isEmpty: Bool {
    switch self {
    case .Some(let val):
      return val.isEmpty
    case .None:
      return true
    }
  }
}

extension String: IsEmptyTestable {}
extension Array: IsEmptyTestable {}
extension Set: IsEmptyTestable {}
extension Dictionary: IsEmptyTestable {}


