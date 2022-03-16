//
//  BookDetailsViewController.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 15.03.2022.
//

import UIKit

class BookDetailsViewController: UIViewController {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var authorsLabel: UILabel!
	@IBOutlet weak var bookImageView: UIImageView!

	var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

	private func setupUI() {
		guard let book = book else { return }
		titleLabel.text = book.title
		descriptionLabel.text = book.description
		authorsLabel.text = book.authors.joined(separator: ", ")

	}
}
