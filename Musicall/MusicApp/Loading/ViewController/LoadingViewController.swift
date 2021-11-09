//
//  LoadingViewController.swift
//  
//
//  Created by Lucas Oliveira on 31/08/21.
//

import UIKit
import Lottie

public class LoadingViewController: UIViewController {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkestGray
        view.layer.cornerRadius = 10
        return view
    }()

    let loadingView: AnimationView = {
        let animationView = AnimationView()
        let url = Bundle.main.url(forResource: "LoadingAnimation", withExtension: "json")
        let animation = Animation.named("LoadingAnimation", bundle: .main, subdirectory: "", animationCache: nil)

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        return animationView
    }()
    
    let loadingWithCompleteView: AnimationView = {
        let animationView = AnimationView()
        let url = Bundle.main.url(forResource: "LoadingWithComplete", withExtension: "json")
        let animation = Animation.named("LoadingWithComplete", bundle: .main, subdirectory: "", animationCache: nil)

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.isHidden = true
        return animationView
    }()

    public init() {
        super.init(nibName: nil, bundle: nil)
        configureLayout()
        view.backgroundColor = UIColor.systemBlack.withAlphaComponent(0.25)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.play()
        loadingWithCompleteView.play()
    }

    private func configureLayout() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(loadingView)
        backgroundView.addSubview(loadingWithCompleteView)

        backgroundView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.center.equalToSuperview()
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingWithCompleteView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
