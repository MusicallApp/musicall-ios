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

    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.bounces = true
        view.separatorStyle = .none

        return view
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

    private let topView = UIView()

    // MARK: Variables and constants

    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        setUpViewModel()
    }
    
    // MARK: Methods
    
    @objc func addPost() {
        coordinator?.navigate(.toCreatePost, with: nil)
    }
    
    private func setUpViewModel() {
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        
        viewModel.getPosts()
    }
}

// MARK: UI Settings

extension MuralViewController {
    
    private func setUpUI() {
        // Navigation Controller
        title = "Mural"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
                    NSAttributedString.Key.font: UIFont.MCDesignSystem(font: .heading1),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
        addButton.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = buttonItem
        
        view.backgroundColor = .black
        
        // Views
        view.addSubview(tableView)
        view.addSubview(topView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        topView.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(topView.snp.bottom)
            make.bottomMargin.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    public func setUpTableView() {
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseId)
        
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
        cell.configureView(card: .init(headerInfos: HeaderInfos(username: cellViewModel.authorName,
                                                                date: cellViewModel.date.description),
                                       style: .complete(content: cellViewModel.content,
                                                        likes: cellViewModel.likes,
                                                        interactions: 0)),
                           bottomSpacing: 16)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigate(.toInteractions, with: viewModel.getCellViewModel(at: indexPath))
    }
    
}
