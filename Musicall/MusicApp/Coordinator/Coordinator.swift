//
//  Coordinator.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

enum Event {
    case goToMural
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func eventOcurred(with type: Event, data: Any?)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
