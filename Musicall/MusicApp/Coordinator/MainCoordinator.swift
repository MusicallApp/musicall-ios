//
//  MainCoordinator.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    func eventOcurred(with type: Event, data: Any?) {
        switch type {
        case .goToMural:
            goToMural(with: data as? User)
        }
    }

    func start() {
        if let user = UserDefaultHelper.getUser() {
            goToMural(with: user)
        } else {
            var viewController: UIViewController & Coordinating = PreSettingsViewController()
            viewController.coordinator = self
            navigationController?.setViewControllers([viewController], animated: false)
        }
    }

    private func goToMural(with data: User?) {
        let viewController: UIViewController = MuralViewController()
        // viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
