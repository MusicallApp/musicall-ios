//
//  MainCoordinator.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?

    func navigate(_ destination: Destination, with data: Any?) {
        switch destination {
        case .toMural:
            goToMural()
        case .toInteractions:
            goToInteractions()
        case .toCreatePost:
            goToCreatePost()
        }
    }

    func start() {
        if UserDefaultHelper.getUser() != nil {
            goToMural()
        } else {
            let viewController = PreSettingsViewController()
            viewController.coordinator = self
            navigationController?.setViewControllers([viewController], animated: false)
        }
    }

    private func goToMural() {
        let viewController = MuralViewController()
        viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: false)
    }

    private func goToInteractions() {
        let viewController = InteractionsViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func goToCreatePost() {
        let viewController = CreatePostViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}
