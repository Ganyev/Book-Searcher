//
//  SearchViewModel.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

class SearchViewModel {
	var books = [Book]()
	
	func fetchBooks(_ query: String, completion: @escaping ([Book]) -> Void) {
//		NetworkService.shared.get(urlString: ConstantsApi.baseUrl + query, completionBlock: { [weak self] json, error in
//			guard let _ = self else { return }
//			if let error = error {
//
//			}
//
//			switch result {
//			case .failure(let error):
//				print("request error", error)
//
//			case .success(let data) :
//				do {
//					guard let json = json as? JSONValue,
//						  let jsonItems = json["items"] as? JSONArray else { return }
//
//					let books = jsonItems.map({ Book($0) })
//					self?.books = books
//					completion(books)
//				} catch {
//
//				}
//			}
//		})
		
		NetworkService.shared.get(urlString: ConstantsApi.baseUrl + query)
		NetworkService.shared.onData = { [weak self] json in
			guard let json = json as? JSONValue,
				let jsonItems = json["items"] as? JSONArray else { return }
			let books = jsonItems.map({ Book($0) })
			self?.books = books
			completion(books)
		}
		NetworkService.shared.onError = { [weak self] errorText in
			guard let text = errorText else {
				print("Unexpected Error")
				return
			}
			print(text)
		}
	}
}
