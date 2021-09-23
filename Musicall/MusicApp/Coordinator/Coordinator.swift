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
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func navigate(_ type: Destination, with data: Any?)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
