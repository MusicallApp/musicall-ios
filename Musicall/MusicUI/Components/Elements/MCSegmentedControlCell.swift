//
//  MCSegmentedControlCell.swift
//  Musicall
//
//  Created by Lucas Oliveira on 04/10/21.
//

import UIKit

protocol MCSegmentedControlCellDelegate: AnyObject {
    var indexSelected: Int { get set }
}

class MCSegmentedControlCell: UIView {
    var isHighlighted = false {
        didSet {
            backgroundColor = isHighlighted ? .blue : .darkestGray
        }
    }

    var text: String = "" {
        didSet {
            label.text = text
        }
    }

    let identifier: Int
    weak var delegate: MCSegmentedControlCellDelegate?

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .MCDesignSystem(font: .subtitle2)
        label.textColor = .white
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(identifier: Int, text: String) {
        self.identifier = identifier
        self.text = text
        super.init(frame: .zero)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
        layer.cornerRadius = 10
        addUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addUI() {
        addSubview(label)

        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    @objc func tapAction() {
        delegate?.indexSelected = identifier
    }
}
