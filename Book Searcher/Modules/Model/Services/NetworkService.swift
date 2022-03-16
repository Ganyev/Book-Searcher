//
//  NetworkService.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

class NetworkService {
	static let shared: NetworkService = NetworkService()

	enum NetworkError: Error {
		case invalidURL
		case invalidResponse(Data?, URLResponse?)
	}

	public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
		guard let url = URL(string: urlString) else {
			completionBlock(.failure(NetworkError.invalidURL))
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil else {
				completionBlock(.failure(error!))
				return
			}

			guard let responseData = data,
				let httpResponse = response as? HTTPURLResponse,
				200 ..< 300 ~= httpResponse.statusCode else {
					completionBlock(.failure(NetworkError.invalidResponse(data, response)))
					return
				}

			completionBlock(.success(responseData))
		}
		task.resume()
	}
}
