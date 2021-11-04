//
//  AlerHelper.swift
//  Musicall
//
//  Created by Elias Ferreira on 17/10/21.
//

import UIKit

protocol AlertDelegate: AnyObject {
    func actionSheetDeleteAction()
    func actionSheetReportAction()
    func actionConfirmDelete()
}

class AlertHelper {

    static func showDeleteActionSheet(on viewController: UIViewController?,
                                      with delegate: AlertDelegate?,
                                      preferredStyle: UIAlertController.Style) {

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: preferredStyle)
        actionSheet.title = "Deseja deletar?"
        actionSheet.message = "Essa ação é irreversivel, tenha certeza ao tomar a decisão"

        actionSheet.addAction(UIAlertAction(title: "Deletar", style: .destructive) { _ in
            delegate?.actionSheetDeleteAction()
        })

        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        viewController?.present(actionSheet, animated: true, completion: nil)
    }

    static func showReportActionSheet(on viewController: UIViewController?,
                                      with delegate: AlertDelegate?,
                                      preferredStyle: UIAlertController.Style) {

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: preferredStyle)
        actionSheet.title = "Deseja deletar?"
        actionSheet.message = "Essa ação é irreversivel, tenha certeza ao tomar a decisão"

        actionSheet.addAction(UIAlertAction(title: "Reportar", style: .destructive) { _ in
            delegate?.actionSheetReportAction()
        })

        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        viewController?.present(actionSheet, animated: true, completion: nil)
    }

    static func showConfimAlert(on viewController: UIViewController?, title: String, message: String, with delegate: AlertDelegate?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Deletar", style: .destructive) { _ in
            delegate?.actionConfirmDelete()
            print("Deletou...")
        })

        viewController?.present(alert, animated: true, completion: nil)
    }
    
    static func showOnlyAlert(on viewController: UIViewController?, title: String, message: String, preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alert.addAction(UIAlertAction(title: "Voltar", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
