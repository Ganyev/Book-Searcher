//
//  Book.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

struct Book: Equatable {
	var title = ""
	var authors = [String]()
	var description = ""
	var thumbnail = ""

	var authorsToDisplay: String {
		return authors.joined(separator: ", ")
	}

	init(_ data: JSONValue) {
		let volumeInfo: JSONValue = data.value("volumeInfo")

		title = volumeInfo.value("title")
		if let authors: [String] = volumeInfo.optionalValue("authors") {
			self.authors = authors
		}
		if let description: String = volumeInfo.optionalValue("description") {
			self.description = description
		}
		if let imageLinks: JSONValue = volumeInfo.optionalValue("imageLinks") {
			thumbnail = imageLinks.value("thumbnail")
		}
	}
}
