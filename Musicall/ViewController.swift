//
//  ViewController.swift
//  Musicall
//
//  Created by Vitor Bryan on 09/09/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let floatActionSheet = FloatActionSheet(imageIcon: UIImage(systemName: "person.crop.circle"),
                                            title: "Compartilhar meu perfil")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(floatActionSheet)

        floatActionSheet.addTarget(target: self, action: #selector(test))

        floatActionSheet.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc
    func test() {
        print("Testando...")
    }

}
