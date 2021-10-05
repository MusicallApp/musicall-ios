//
//  MCSegmentedControl.swift
//  Musicall
//
//  Created by Lucas Oliveira on 01/10/21.
//

import UIKit
import SnapKit

protocol MCSegmentedControlDelegate: AnyObject {
    func changeIndexSelected(index: Int)
}

class MCSegmentedControl: UIView, MCSegmentedControlCellDelegate {

    // MARK: Public Methods
    var indexSelected: Int = 0 {
        didSet {
            leftOption.isHighlighted.toggle()
            rightOption.isHighlighted.toggle()
            delegate?.changeIndexSelected(index: indexSelected)
        }
    }

    weak var delegate: MCSegmentedControlDelegate?

    // MARK: UI Elements

    let leftOption: MCSegmentedControlCell
    let rightOption: MCSegmentedControlCell

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Life Cycle
    init(options: (left: String, right: String)) {

        leftOption = .init(identifier: 0, text: options.left)
        leftOption.isHighlighted = true

        rightOption = .init(identifier: 1, text: options.right)
        super.init(frame: .zero)

        leftOption.delegate = self
        rightOption.delegate = self

        backgroundColor = .darkestGray
        layer.cornerRadius = 10

        configureStackView(options)
        configureUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Privates Methods
    private func configureUI() {
        addSubview(mainStackView)

        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    private func configureStackView(_ options: (left: String, right: String)) {
        mainStackView.addArrangedSubview(leftOption)
        mainStackView.addArrangedSubview(UIView())
        mainStackView.addArrangedSubview(rightOption)

    }
}
