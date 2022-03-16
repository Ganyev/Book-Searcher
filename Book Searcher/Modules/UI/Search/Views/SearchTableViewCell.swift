//
//  SearchTableViewCell.swift
//  Book Searcher
//
//  Created by Bakhtiyar Ganyev on 16.03.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var authorsLabel: UILabel!
	@IBOutlet weak var bookImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

	func setup(with book: Book) {
		titleLabel.text = book.title
		descriptionLabel.text = book.description
		authorsLabel.text = book.authorsToDisplay
		bookImageView.downloaded(from: book.thumbnail)
	}
}
