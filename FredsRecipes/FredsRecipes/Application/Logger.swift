//
//  Logger.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/22/25.
//

import Foundation

struct Logger {
  /// Level describes the severity of the logged expression. By default, debug level
  /// statements will only be printed when the app is run in DEBUG mode, otherwise,
  /// they are ignored in RELEASE builds.
  enum Level: CustomStringConvertible {
    case debug
    case info
    case warn
    case error
    
    var description: String {
      switch self {
      case .debug:
        return "DEBUG"
      case .info:
        return "INFO"
      case .warn:
        return "WARN"
      case .error:
        return "ERROR"
      }
    }
  }
  
  /// Logs the provided expression to the console using the DEBUG log level.
  static func d<T>(_ expr: @autoclosure () -> T,
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {
#if DEBUG
    let level = Level.debug
    let file = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    print("[\(level)]\(file).\(function)[\(line)]: \(expr())")
#endif
  }
  
  /// Writes a line to the console log containing the given expression, file, function,
  /// and line using the info log level.
  static func i<T>(_ expr: @autoclosure () -> T,
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {
    let level = Level.info
    let file = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    print("[\(level)]\(file).\(function)[\(line)]: \(expr())")
  }
  
  /// Writes a line to the console log containing the given expression, file, function,
  /// and line using the warn log level.
  static func w<T>(_ expr: @autoclosure () -> T,
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {
    let level = Level.warn
    let file = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    print("[\(level)]\(file).\(function)[\(line)]: \(expr())")
  }
  
  /// Logs the provided expression to the console using the ERROR log level and
  /// creates an associated AppExceptionEntity record for this error.  Informs
  /// the UploadManager of this error so it can attempt to upload it to the server.
  static func e<T>(_ expr: @autoclosure () -> T,
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {
    let level = Level.error
    let file = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    let message = "[\(level)]\(file).\(function)[\(line)]: \(expr())"
    print(message)
  }
}
