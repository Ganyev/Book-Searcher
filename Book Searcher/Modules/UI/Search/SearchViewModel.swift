//
//  SearchViewModel.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

class SearchViewModel {
	var books = [Book]()
	weak var networkService: NetworkService!

	init(networkService: NetworkService = NetworkService()) {
		self.networkService = networkService
	}

	func fetchBooks(_ query: String, completion: @escaping ([Book]) -> Void) {
		
		// Due to lack of the time, need to be refactored (e.g. use third-party networking libraries)
		NetworkService.shared.get(urlString: ConstantsApi.baseUrl + query, completionBlock: { [weak self] result in
			guard let _ = self else { return }

			switch result {
			case .failure(let error):
				// todo: handle errors
				print("Request error", error.localizedDescription)

			case .success(let json) :
				guard let json = json as? JSONValue,
					  let jsonItems = json["items"] as? JSONArray else { return }

				let books = jsonItems.map({ Book($0) })
				self?.books = books
				completion(books)
			}
		})
	}
}
