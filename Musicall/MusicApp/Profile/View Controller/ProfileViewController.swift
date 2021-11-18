//
//  ProfileViewController.swift
//  Musicall
//
//  Created by Lucas Oliveira on 16/11/21.
//

import Foundation
import UIKit
import CloudKit

class ProfileViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?

    let profileView = ProfileView()
    let viewModel: ProfileViewModel

    override func loadView() {
        super.loadView()

        view = profileView
        profileView.name = viewModel.model.name
        profileView.time = viewModel.model.date
        profileView.delegate = viewModel

    }

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        configureClousures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .blue
    }

    func configureClousures() {
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.profileView.stopLoading()
                self.profileView.tableView.reloadData()
            }
        }

        profileView.cellDidSelected = { viewModel in
            self.coordinator?.navigate(.toInteractions, with: viewModel)
        }
    }
}
