//
//  SearchViewController.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import UIKit

final class SearchViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!

	private lazy var viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
		configureUI()
    }
    
	private func configureUI() {
		tableView.dataSource = self
		tableView.delegate = self
		searchBar.delegate = self
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		performSearch(text)
		return !text.isRestrictedSymbol()
	}
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.books.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
		let book = viewModel.books[indexPath.row]
		cell.setup(with: book)
		return cell
	}
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let book = viewModel.books[indexPath.row]
		navigateToBookDetailsScreen(book)
	}
}

// MARK: - Private methods
extension SearchViewController {
	private func performSearch(_ query: String) {
		viewModel.fetchBooks(query) { [weak self] books in
			self?.reloadData()
		}
	}

	private func reloadData() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
	}

	private func navigateToBookDetailsScreen(_ book: Book) {
		let bookDetailsViewController = BookDetailsViewController(book: book)
		self.navigationController?.pushViewController(bookDetailsViewController, animated: true)
	}
}
