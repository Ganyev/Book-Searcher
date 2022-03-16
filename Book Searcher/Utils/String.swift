//
//  String.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

extension String {
	func isRestrictedSymbol() -> Bool {
	   return self == "\\" || self == "|" || self == "/" || self == "~" || self == "*"
	}
}
