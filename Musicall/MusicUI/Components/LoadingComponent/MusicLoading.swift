//
//  MusicLoading.swift
//  Musicall
//
//  Created by Lucas Oliveira on 05/11/21.
//

import Lottie
import UIKit

class MusicLoading: UIView {
    let loadingView: AnimationView = {
        let animationView = AnimationView()
        let url = Bundle.main.url(forResource: "LoadingAnimation", withExtension: "json")
        let animation = Animation.named("LoadingAnimation", bundle: .main, subdirectory: "", animationCache: nil)

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        return animationView
    }()

    init() {
        super.init(frame: .null)
        backgroundColor = .darkestGray
        layer.cornerRadius = 10
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(loadingView)

        loadingView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.edges.equalToSuperview()
        }
    }
}
