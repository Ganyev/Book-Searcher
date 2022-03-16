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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setup(with book: Book) {
		titleLabel.text = book.title
		descriptionLabel.text = book.description
		authorsLabel.text = book.authors.joined(separator: ", ")
//		bookImageView.image = UIImage(
	}
}