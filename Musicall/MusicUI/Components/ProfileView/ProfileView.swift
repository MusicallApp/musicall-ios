//
//  ProfileView.swift
//  Musicall
//
//  Created by Lucas Oliveira on 14/09/21.
//

import UIKit
class ProfileView: UIView {
    
    // MARK: UI Elements
    let mainHorizontalStack: UIStackView = {
        let stackHorizontal = UIStackView()
        stackHorizontal.axis = .horizontal
        stackHorizontal.alignment = .fill
        stackHorizontal.distribution = .fill
        stackHorizontal.spacing = 12
        return stackHorizontal
    }()

    let verticalStack: UIStackView = {
        let stackHorizontal = UIStackView()
        stackHorizontal.axis = .vertical
        stackHorizontal.alignment = .fill
        stackHorizontal.distribution = .fill
        stackHorizontal.spacing = 0
        return stackHorizontal
    }()
}
