//
//  BookTableViewCell.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit

final class BookTableViewCell: UITableViewCell {
    @IBOutlet private weak var bookLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func setupCell(with data: BookCellDataSource) {
        bookLabel.text = data.bookSymbol
        priceLabel.text = data.lastPrice
    }
}
