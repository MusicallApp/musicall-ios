//
//  MuralViewController.swift
//  Musicall
//
//  Created by Vitor Bryan on 09/09/21.
//

import UIKit

class MuralViewController: UIViewController {
    
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
        button.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        
        return button
    }()
    
    private let topView = UIView()
    
    // MARK: Variables and constants
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        
        let cloudKit = ModelCloudKit()
        cloudKit.fetchPost { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Methods
    
    @objc func addPost() {
        
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
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MuralViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath)
        guard cell is CardTableViewCell else { return cell }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height * 0.2
    }
    
}
