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

    override func loadView() {
        super.loadView()
        self.view = interactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "interações"
    }

}
