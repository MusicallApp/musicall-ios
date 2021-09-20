//
//  CardCell.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit

class CardCell: UITableViewCell {

    // MARK: Properties
    public static let reuseId = "CardCell"

    private(set) var card: Card?

    public override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = reuseId) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public APIs
    public func configureView(card: Card) {
        self.card = card
        addSubview(card)

        card.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
