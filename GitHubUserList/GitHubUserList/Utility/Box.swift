//
//  Box.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

/// Inspired by raywenderlich: https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc
final class Box<T> {

  typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
