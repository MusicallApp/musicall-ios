//
//  MainCoordinator.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?

    func navigate(_ destination: Destination, with data: Any?) {
        switch destination {
        case .toMural:
            goToMural()
        case .toInteractions:
            if let post = data as? PostListViewModel {
                goToInteractions(with: post)
            }
        case .toCreatePost:
            goToCreatePost()
        case .toReport:
            if let report = data as? Report {
                goToReport(with: report)
            }
        case .toConfirmReport:
            let delegate = data as? ReportDelegate
            goToConfirmReport(with: delegate)
        case .toSignIn:
            goToSignIn()
        case.toSignUp:
            goToSignUp()
        case .toProfile:
            if let model = data as? ProfileModel {
                goToProfile(with: model)
            }
        }
    }

    func start() {
        if UserDefaultHelper.getUser() != nil {
            goToMural()
        } else {
            let viewController = LoginViewController()
            viewController.coordinator = self
            navigationController?.setViewControllers([viewController], animated: false)
        }
    }
    
    func pop(_ viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }

    func dismiss(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }

    private func goToMural() {
        let viewController = MuralViewController()
        viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: false)
    }

    private func goToInteractions(with post: PostListViewModel) {
        let viewController = InteractionsViewController()
        viewController.coordinator = self
        viewController.setUpViewModel(post: post)
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    private func goToCreatePost() {
        let viewController = CreatePostViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func goToReport(with report: Report) {
        let viewController = ReportViewController()
        viewController.report = report
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func goToConfirmReport(with delegate: ReportDelegate?) {
        let viewController = ConfirmReportViewController()
        viewController.coordinator = self
        viewController.delegate = delegate
        let nvc = UINavigationController()
        nvc.setViewControllers([viewController], animated: false)
        nvc.modalPresentationStyle = .fullScreen

        navigationController?.present(nvc, animated: true, completion: nil)
    }
    
    private func goToSignIn() {
        
    }
    
    private func goToSignUp() {
        let viewController = PreSettingsViewController()
        viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: false)
    }
    
    private func goToProfile(with model: ProfileModel) {
        let viewController = ProfileViewController(viewModel: .init(model: model))
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}
