//
//  ViewController.swift
//  Musicall
//
//  Created by Vitor Bryan on 09/09/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let button = MCButton(style: .ghost, size: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        button.setImage(UIImage(named: "Paperclip"), for: .normal)
        view.addSubview(button)

        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }

}
