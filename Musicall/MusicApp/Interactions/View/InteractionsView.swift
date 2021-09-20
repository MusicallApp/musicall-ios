//
//  InteractionsView.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit
import SnapKit

class InteractionsView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    private let keyboardTextField = KeyboardTexField(placeholder: "Escreva um comentário...")

    init() {
        super.init(frame: .null)
        self.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(keyboardTextField)
        addSubview(tableView)

        keyboardTextField.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { makeText in
            <#code#>
        }
    }
}
