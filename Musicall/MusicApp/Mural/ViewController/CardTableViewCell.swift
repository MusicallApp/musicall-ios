//
//  CardTableViewCell.swift
//  Musicall
//
//  Created by Vitor Bryan on 21/09/21.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    static let identifier = "cardTableViewCell"
    
    fileprivate let cardView = Card(headerInfos: HeaderInfos(username: "Braia", date: "21/07"),
                                    style: .simple(content: "asjkfgadhjsfgakj"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(cardView)
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        cardView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
