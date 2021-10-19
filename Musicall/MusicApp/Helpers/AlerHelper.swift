//
//  AlerHelper.swift
//  Musicall
//
//  Created by Elias Ferreira on 17/10/21.
//

import UIKit

protocol AlertDeleteDelegate: AnyObject {
    func actionSheetDeleteAction()
}

class AlertHelper {

    static func showDeleteActionSheet(on viewController: UIViewController?, with delegate: AlertDeleteDelegate?) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Deletar", style: .destructive) { _ in
            delegate?.actionSheetDeleteAction()
        })

        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        viewController?.present(actionSheet, animated: true, completion: nil)
    }

    static func showConfimAlert(on viewController: UIViewController?, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Deletar", style: .destructive) { _ in
            print("Deletou...")
        })

        viewController?.present(alert, animated: true, completion: nil)
    }
}
