//
//  Coordinator.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

enum Destination {
    case toMural
    case toInteractions
    case toCreatePost
    case toReport
    case toConfirmReport
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func navigate(_ type: Destination, with data: Any?)
    func dismiss(_ viewController: UIViewController, completion: (() -> Void)?)
    func start()
    func pop(_ viewController: UIViewController)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
