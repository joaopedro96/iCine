//
//  CNOnboardingHomeBackgroundSectionView.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit
import SnapKit

final class CNOnboardingHomeBackgroundSectionView: UIView {

    // MARK: - INITIALIZERS

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var onboardingPoster: UIImageView = {
        let setupComponent = UIImageView()
        setupComponent.contentMode = .scaleToFill
        setupComponent.image = .onboardingPoster
        return setupComponent
    }()

    private lazy var backgroundGradient: UIView = {
        let setupComponent = UIView(frame: .zero)
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        let gradient = CAGradientLayer()
        gradient.frame = UIScreen.main.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.bgDark.cgColor]
        gradient.locations = [0.2, 0.6]
        setupComponent.layer.insertSublayer(gradient, at: 0)
        return setupComponent
    }()

    // MARK: - SETUP VIEW

    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }

    private func buildViewHierarchy() {
        addSubviews(onboardingPoster, backgroundGradient)
    }

    private func setupConstraints() {
        onboardingPoster.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 1.64)
        }

        backgroundGradient.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
