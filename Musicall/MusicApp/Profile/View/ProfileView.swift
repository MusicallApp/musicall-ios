//
//  ProfileView.swift
//  Musicall
//
//  Created by Lucas Oliveira on 16/11/21.
//

import UIKit
import CloudKit

protocol ProfileViewDelegate: AnyObject {
    var posts: [Post] { get set }
    var cellViewModels: [PostListViewModel] { get set }
}

class ProfileView: UIView {

    // MARK: Properties
    weak var delegate: ProfileViewDelegate?
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    var time: String = "" {
        didSet {
            timeLabel.text = "Usuário desde \(time)"
        }
    }

    var cellDidSelected: ((PostListViewModel) -> Void)?

    // MARK: UI Elements
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .MCDesignSystem(font: .title1)
        label.textColor = .white
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .MCDesignSystem(font: .body)
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        return separator
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.bounces = true
        view.separatorStyle = .none

        view.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseId)
        view.delegate = self
        view.dataSource = self

        return view
    }()

    private lazy var loadingView = MusicLoading()

    init() {
        super.init(frame: .null)

        backgroundColor = .black
        loadingView.loadingView.play()

        setupStackView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        profileStackView.addArrangedSubview(nameLabel)
        profileStackView.addArrangedSubview(timeLabel)

    }

    public func stopLoading() {
        loadingView.loadingView.stop()
        loadingView.isHidden = true
    }

    private func setupConstraints() {
        addSubview(profileStackView)
        addSubview(separator)
        addSubview(tableView)
        addSubview(loadingView)

        profileStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin).inset(16)
            make.left.right.equalToSuperview().inset(16)
        }

        separator.snp.makeConstraints { make in
            make.top.equalTo(profileStackView.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(36)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }

}

extension ProfileView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.posts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseId,
                                                       for: indexPath) as? CardCell else {
            fatalError("Cell not exists")
        }

        guard let post = delegate?.posts[indexPath.row],
              let viewModel = delegate?.cellViewModels[indexPath.row] else {
            return UITableViewCell()
        }

        let headerView = HeaderInfos(username: viewModel.authorName,
                                     date: viewModel.date.getFormattedDate(format: .dayMonth))

        cell.configureView(card: .init(headerInfos: headerView,
                                       style: .complete(content: post.content,
                                                        likes: post.likes,
                                                        interactions: post.comment?.count ?? 0)),
                           bottomSpacing: 16)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellViewModel = delegate?.cellViewModels[indexPath.row] else {
            return
        }

        cellDidSelected?(cellViewModel)
    }
}
