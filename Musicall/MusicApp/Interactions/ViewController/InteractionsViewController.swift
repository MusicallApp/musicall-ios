//
//  InteractionsViewController.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit

class InteractionsViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    private let interactionsView = InteractionsView()
    
    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .white
        return indicator
    }()

    override func loadView() {
        super.loadView()
        self.view = interactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        
        title = "interações"
        navigationItem.largeTitleDisplayMode = .never
        
        setUpSpinner()
    }
    
    func setUpSpinner() {
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func setUpViewModel(post: Post) {
        spinner.startAnimating()
        interactionsView.viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.interactionsView.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }

        interactionsView.viewModel.showError = {
            DispatchQueue.main.async {
                print("Error")
            }
        }

        interactionsView.viewModel.showLoading = {
            DispatchQueue.main.async {
            }
        }

        interactionsView.viewModel.hideLoading = {
            DispatchQueue.main.async {
            }
        }

        interactionsView.viewModel.createCells(post: post)
    }

}
