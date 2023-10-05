//
//  CNButton.swift
//  iCine
//
//  Created by João Pedro Mata on 23/09/23.
//

import UIKit
import Lottie

enum CNButtonType {
    case primary
    case secondary
}

final class CNButton: UIButton {
    
    // MARK: - PROPERTIES
    
    var type: CNButtonType = .primary {
        didSet {
            setupTypeProperties()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            setupTypeProperties()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            shouldShowLoading()
        }
    }
    
    private var previousTitle: String? = ""
    
    // MARK: - UI
    
    private lazy var loadingView: LottieAnimationView = {
        let setupComponent = LottieAnimationView(name: "button_loading")
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.loopMode = .loop
        setupComponent.isHidden = true
        return setupComponent
    }()
    
    // MARK: - INITIALIZERS
    
    init(buttonType: CNButtonType = .primary) {
        type = buttonType
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func shouldShowLoading() {
        isEnabled = !isLoading
        loadingView.isHidden = !isLoading
        isEnabled ? loadingView.stop() : loadingView.play()
        updateTitle()
    }
    
    private func updateTitle() {
        if isLoading {
            previousTitle = currentTitle
            setTitle("", for: .normal)
        } else {
            setTitle(previousTitle, for: .normal)
        }
    }
    
    // MARK: - SETUP VIEW
    
    private func setupButton() {
        setupDefaultProperties()
        setupTypeProperties()
    }
    
    private func setupDefaultProperties() {
        layer.cornerRadius = 8
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        addLoadingView()
    }
    
    private func setupTypeProperties() {
        switch type {
            case .primary:
                setupPrimaryButton()
                
            case .secondary:
                setupSecondaryButton()
        }
    }
    
    private func setupPrimaryButton() {
        setTitleColor(isEnabled ? .txtSecondary : .txtTertiary, for: .normal)
        backgroundColor = isEnabled ? .bgLight: .bgDisable
    }
    
    private func setupSecondaryButton() {
        setTitleColor(.txtPrimary, for: .normal)
        backgroundColor = . clear
        layer.borderColor = UIColor.bgLight.cgColor
        layer.borderWidth = 1
    }
    
    private func addLoadingView() {
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(44)
        }
    }
}
