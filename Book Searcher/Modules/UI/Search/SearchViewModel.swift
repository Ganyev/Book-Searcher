//
//  SearchViewModel.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

class SearchViewModel {
	var books = [Book]()
	var searchTimer: Timer?
	
	func fetchBooks(_ query: String, completion: @escaping ([Book]) -> Void) {
		self.searchTimer?.invalidate()

		// added debounce
		searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
			DispatchQueue.global(qos: .userInteractive).async { [weak self] in
				NetworkService.shared.get(urlString: ConstantsApi.baseUrl + query, completionBlock: { [weak self] result in
					guard let _ = self else { return }
					switch result {
					case .failure(let error):
						print("request error", error)
						
					case .success(let data) :
						do {
							print("123")
							var json = try? JSONSerialization.jsonObject(with: data, options: [])
							if json == nil, var str = String(bytes: data, encoding: .utf8) {
								str = str.replacingOccurrences(of: "\n", with: "\\n")
								str = str.replacingOccurrences(of: "\r", with: "\\r")
								str = str.replacingOccurrences(of: "\t", with: "\\t")
								str = str.replacingOccurrences(of: "\\\"", with: "\"")
								if let dataFromString = str.data(using: .utf8) {
									json = try? JSONSerialization.jsonObject(with: dataFromString, options: [])
								}
							}
							
							guard let json = json as? JSONValue,
								  let jsonItems = json["items"] as? JSONArray else { return }
							
							let books = jsonItems.map({ Book($0) })
							self?.books = books
							completion(books)
						} catch {
							
						}
					}
				})
			}
		})
	}
}
