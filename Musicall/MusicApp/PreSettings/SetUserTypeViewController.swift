//
//  SetUserTypeViewController.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

class SetUserTypeViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

}
