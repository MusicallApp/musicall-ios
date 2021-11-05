//
//  AlerHelper.swift
//  Musicall
//
//  Created by Elias Ferreira on 17/10/21.
//

import UIKit

enum Action: String {
    case delete
    case ban
}

protocol AlertDelegate: AnyObject {
    func actionSheetDeleteAction()
    func actionSheetReportAction()
    func actionSheetBanAction()
    func actionConfirmDelete()
    func actionConfirmBan()
}

class AlertHelper {

    static func showDeleteActionSheet(on viewController: UIViewController?,
                                      with delegate: AlertDelegate?,
                                      preferredStyle: UIAlertController.Style) {

        let actionSheet = UIAlertController(title: "Ações", message: nil, preferredStyle: preferredStyle)

        actionSheet.addAction(UIAlertAction(title: "Deletar", style: .destructive) { _ in
            delegate?.actionSheetDeleteAction()
        })

        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        viewController?.present(actionSheet, animated: true, completion: nil)
    }

    static func showOptionsActionSheet(on viewController: UIViewController?,
                                       with delegate: AlertDelegate?,
                                       preferredStyle: UIAlertController.Style) {

        let actionSheet = UIAlertController(title: "Ações", message: nil, preferredStyle: preferredStyle)

        actionSheet.addAction(UIAlertAction(title: "Reportar", style: .destructive) { _ in
            delegate?.actionSheetReportAction()
        })

        actionSheet.addAction(UIAlertAction(title: "Banir usuário", style: .destructive) { _ in
            delegate?.actionSheetBanAction()
        })

        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        viewController?.present(actionSheet, animated: true, completion: nil)
    }

    static func showConfimAlert(on viewController: UIViewController?,
                                title: String,
                                message: String,
                                with delegate: AlertDelegate?,
                                action: Action) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        switch action {
        case .delete:
            alert.addAction(UIAlertAction(title: "Deletar", style: .destructive) { _ in
                delegate?.actionConfirmDelete()
            })
        case .ban:
            alert.addAction(UIAlertAction(title: "Banir", style: .destructive) { _ in
                delegate?.actionConfirmBan()
            })
        }

        viewController?.present(alert, animated: true, completion: nil)
    }
    
    static func showOnlyAlert(on viewController: UIViewController?,
                              title: String,
                              message: String,
                              preferredStyle: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alert.addAction(UIAlertAction(title: "Voltar", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
