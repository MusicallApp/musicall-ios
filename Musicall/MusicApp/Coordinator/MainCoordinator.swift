//
//  MainCoordinator.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?

    func eventOcurred(with type: Event) {
    }

    func start() {
        var viewController: UIViewController & Coordinating = PreSettingsViewController()
        viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
