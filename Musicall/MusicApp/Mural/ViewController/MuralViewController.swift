//
//  MuralViewController.swift
//  Musicall
//
//  Created by Vitor Bryan on 09/09/21.
//

import UIKit

class MuralViewController: UIViewController, Coordinating {

    // MARK: Setup

    let viewModel = MuralViewModel()

    // MARK: UI

    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill

        stackView.addArrangedSubview(largeTitleLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(button)

        return stackView
    }()

    private let largeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .MCDesignSystem(font: .heading1)
        label.text = "Mural"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let button: MCButton = {
        let button = MCButton(style: .primary, size: .large)
        button.setImage(.icPlus, for: .normal)
        button.addTarget(self, action: #selector(addPost), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.bounces = true
        view.separatorStyle = .none

        return view
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .white
        return indicator
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.setImage(UIImage.icPlus, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        return button
    }()

    // MARK: Variables and constants

    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        setUpViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        viewModel.getPosts()
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Methods
    
    @objc func addPost() {
        coordinator?.navigate(.toCreatePost, with: nil)
    }
    
    @objc func reloadPost() {
        viewModel.getPosts()
        tableView.refreshControl?.endRefreshing()
    }
    
    private func setUpViewModel() {
        spinner.startAnimating()
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }
        
        viewModel.showError = {
            DispatchQueue.main.async {
                print("Error")
            }
        }
        
        viewModel.showLoading = {
            DispatchQueue.main.async {
            }
        }
        
        viewModel.hideLoading = {
            DispatchQueue.main.async {
            }
        }
    }
}

// MARK: UI Settings

extension MuralViewController {
    
    private func setUpUI() {
        view.backgroundColor = .black
        
        // Views
        view.addSubview(headerStackView)
        view.addSubview(tableView)
        view.addSubview(spinner)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerStackView.snp.bottom).inset(-12)
            make.bottomMargin.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    public func setUpTableView() {
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseId)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadPost), for: .valueChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MuralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseId,
                                                       for: indexPath) as? CardCell else {
            fatalError("Cell not exists")
        }
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)

        let headerView = HeaderInfos(username: cellViewModel.authorName,
                                     date: cellViewModel.date.getFormattedDate(format: .dayMonth))

        cell.configureView(card: .init(headerInfos: headerView,
                                       style: .complete(content: cellViewModel.content,
                                                        likes: cellViewModel.likes,
                                                        interactions: 0)), bottomSpacing: 16)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigate(.toInteractions, with: viewModel.posts[indexPath.row])
    }
    
}
