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
            let viewController: UIViewController = MuralViewController()
            // viewController.coordinator = self
            navigationController?.setViewControllers([viewController], animated: false)
        }
    }

    func start() {
        if UserDefaultHelper.get(field: .userNickName) != nil {
            let viewController: UIViewController = MuralViewController()
            // viewController.coordinator = self
            navigationController?.setViewControllers([viewController], animated: false)
        } else {
            var viewController: UIViewController & Coordinating = PreSettingsViewController()
            viewController.coordinator = self
            navigationController?.setViewControllers([viewController], animated: false)
        }
    }
}
