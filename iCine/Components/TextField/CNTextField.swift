//
//  CNTextField.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNTextFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
    func textFieldShouldReturn(_ textField: UITextField)
    func textFieldDidChangeEditing(textField: UITextField, newText: String?)
}

extension CNTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) { }
    func textFieldDidEndEditing(_ textField: UITextField) { }
    func textFieldShouldReturn(_ textField: UITextField) { }
    func textFieldDidChangeEditing(textField: UITextField, newText: String?) { }
}

final class CNTextField: UIView {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNTextFieldDelegate?
    
    var autoCapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            textField.autocapitalizationType = autoCapitalizationType
        }
    }
    
    var autoCorrectionType:  UITextAutocorrectionType = .default {
        didSet {
            textField.autocorrectionType = .default
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            hideIcon.isHidden = !isSecureTextEntry
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var placeholderText: String = "" {
        didSet {
            updatePlaceholder()
        }
    }
    
    var placeholderTextColor: UIColor = .txtTertiary {
        didSet {
            updatePlaceholder()
        }
    }
    
    var placeholderFont: UIFont = .systemFont(ofSize: 16, weight: .regular) {
        didSet {
            updatePlaceholder()
        }
    }
        
    var isFilled: Bool = false
    
    var text: String = ""
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var textField: UITextField = {
        let setupComponent = UITextField()
        setupComponent.translatesAutoresizingMaskIntoConstraints = false
        setupComponent.backgroundColor = .bgDarkGrey
        setupComponent.layer.cornerRadius = 8
        setupComponent.layer.borderWidth = 1
        setupComponent.layer.borderColor = UIColor.borderLightGrey.cgColor
        setupComponent.heightAnchor.constraint(equalToConstant: 40).isActive = true
        setupComponent.leftView = setPadding(with: 16)
        setupComponent.rightView = setPadding(with: 32)
        setupComponent.leftViewMode = .always
        setupComponent.rightViewMode = .always
        setupComponent.delegate = self
        return setupComponent
    }()
    
    private lazy var hideIcon: UIImageView = {
        let setupComponent = UIImageView(frame: .zero)
        setupComponent.image = .eyeIcon.withTintColor(.bgLightGrey)
        setupComponent.isHidden = true
        setupComponent.contentMode = .scaleAspectFit
        setupComponent.isUserInteractionEnabled = true
        setupComponent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHideIcon)))
        return setupComponent
    }()
    
    // MARK: - PUBLIC METHODS
    
    func getTextField() -> UITextField {
        return textField
    }
    
    func closeKeyboard() {
        textField.endEditing(true)
    }
    
    // MARK: - PRIVATE METHODS
    
    private func shouldHighlightTextField(_ state: Bool) {
        let borderColor: UIColor = state ? .borderLight : .borderLightGrey
        textField.layer.borderColor = borderColor.cgColor
    }
    
    private func updatePlaceholder() {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderTextColor,
            .font: placeholderFont
        ]
        let attributedString = NSAttributedString(
            string: placeholderText,
            attributes: placeholderAttributes
        )
        textField.attributedPlaceholder = attributedString
    }
    
    private func setPadding(with padding: CGFloat) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: padding, height: 1)
        return UIView(frame: frame)
    }
    
    @objc private func didTapHideIcon() {
        textField.isSecureTextEntry.toggle()
        let state = textField.isSecureTextEntry
        hideIcon.image = state ? .eyeIcon.withTintColor(.bgLightGrey) : .slashedEyeIcon.withTintColor(.bgLight)
    }
    
    // MARK: - SETUP VIEW
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubviews(textField, hideIcon)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hideIcon.snp.makeConstraints { make in
            make.top.equalTo(textField).offset(4)
            make.trailing.equalTo(textField).inset(6)
            make.bottom.equalTo(textField).inset(4)
            make.width.equalTo(24)
        }
    }
}

// MARK: - EXTENSIONS

extension CNTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        shouldHighlightTextField(true)
        delegate?.textFieldDidEndEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        shouldHighlightTextField(false)
        delegate?.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldReturn(textField)
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text as? NSString
        let newString = currentText?.replacingCharacters(in: range, with: string)
        text = newString ?? ""
        delegate?.textFieldDidChangeEditing(textField: textField, newText: newString)
        return true
    }
}
