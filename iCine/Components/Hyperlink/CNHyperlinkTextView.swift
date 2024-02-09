//
//  CNHyperlinkTextView.swift
//  iCine
//
//  Created by João Pedro Mata on 12/10/23.
//

import UIKit

protocol CNHyperlinkTextViewDelegate: AnyObject {
    func triggerLink(for url: URL, atRange range: NSRange)
}

final class CNHyperlinkTextView: UITextView {

    // MARK: - PROPERTIES

    weak var hyperlinkDelegate: CNHyperlinkTextViewDelegate?

    override var textColor: UIColor? {
        didSet {
            if (tintColor == .systemBlue) { setHyperlinkColor(textColor) }
        }
    }

    // MARK: - INITIALIZERS

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PUBLIC METHODS

    func setHyperlinks(_ dictionary: [String: String]) {
        let mutableString = NSMutableAttributedString(attributedString: attributedText)

        for (targetString, stringUrl) in dictionary {
            let linkRange = mutableString.mutableString.range(of: targetString)
            let fontSize = font?.pointSize ?? 16

            let attributes: [NSAttributedString.Key: Any] = [
                .link: stringUrl,
                .font: UIFont.inter(ofSize: fontSize, weight: .bold),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            mutableString.addAttributes(attributes, range: linkRange)
        }
        attributedText = mutableString
    }

    func setHyperlinkColor(_ color: UIColor?) {
        tintColor = color
    }

    // MARK: - SETUP VIEW

    private func setupView() {
        configureTextView()
        customizeTextView()
    }

    private func configureTextView() {
        delegate = self
        isEditable = false
        isScrollEnabled = false
        isSelectable = true
    }

    private func customizeTextView() {
        backgroundColor = .clear
    }
}

// MARK: - EXTENSIONS

extension CNHyperlinkTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        hyperlinkDelegate?.triggerLink(for: URL, atRange: characterRange)
        return false
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.selectedTextRange = nil
    }
}
