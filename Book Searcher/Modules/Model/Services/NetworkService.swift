//
//  NetworkService.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import Foundation

class NetworkService {
	static let shared: NetworkService = NetworkService()

	public func get(urlString: String, completionBlock: @escaping (Result<Any?, Error>) -> Void) {
		guard let url = URL(string: urlString) else {
			print("Invalid URL")
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
					return
				}
			
			var json = try? JSONSerialization.jsonObject(with: responseData, options: [])
			if json == nil, var str = String(bytes: responseData, encoding: .utf8) {
				str = str.replacingOccurrences(of: "\n", with: "\\n")
				str = str.replacingOccurrences(of: "\r", with: "\\r")
				str = str.replacingOccurrences(of: "\t", with: "\\t")
				str = str.replacingOccurrences(of: "\\\"", with: "\"")
				if let dataFromString = str.data(using: .utf8) {
					json = try? JSONSerialization.jsonObject(with: dataFromString, options: [])
				}
			}
			
			completionBlock(.success(json))
		}
		task.resume()
	}
}
