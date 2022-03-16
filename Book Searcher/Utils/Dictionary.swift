//
//  Dictionary.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 16.03.2022.
//

import Foundation

typealias JSONValue = [String: Any]
typealias JSONArray = [JSONValue]

// helps to get deep values in dictionaries inside dictionaries of string key
extension Dictionary where Key == String {
	func value<T>(_ path: String) -> T {
		var s = path
		var val: JSONValue = self

		while let r = s.range(of: ".") {
			let level = String(s[..<r.lowerBound])
			s.removeSubrange(s.startIndex...r.lowerBound)
			val = val[level] as! JSONValue
		}

		return val[s] as! T
	}

	func optionalValue<T>(_ path: String) -> T! {
		var s = path
		var val: JSONValue = self

		while let r = s.range(of: ".") {
			let level = String(s[..<r.lowerBound])
			s.removeSubrange(s.startIndex...r.lowerBound)
			if let jsonValue = val[level] as? JSONValue {
				val = jsonValue
			} else {
				return nil
			}
		}

		return val[s] as? T
	}
}
