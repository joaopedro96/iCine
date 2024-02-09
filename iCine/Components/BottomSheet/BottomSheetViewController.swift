//
//  BottomSheetViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 07/10/23.
//  Source: https://github.com/lrssv/BottomSheet

import UIKit

protocol BottomSheetProtocol: UIAdaptivePresentationControllerDelegate, AnyObject where Self: UIView { }

class BottomSheetViewController: UIPresentationController {

    // MARK: - PROPERTIES

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let presentedView = presentedView,
              let containerView = containerView else { return .zero }
        let size = presentedView.systemLayoutSizeFitting(
            containerView.bounds.size,
            withHorizontalFittingPriority: UILayoutPriority.required,
            verticalFittingPriority: UILayoutPriority.fittingSizeLevel
        )
        let origin = CGPoint(x: 0, y: (containerView.bounds.height - size.height))
        return .init(origin: origin, size: size)
    }

    private lazy var tapGesture: UITapGestureRecognizer = {
        .init(target: self, action: #selector(BottomSheetViewController.handleTapGesture))
    }()

    private lazy var panGesture: UIPanGestureRecognizer = {
        .init(target: self, action: #selector(BottomSheetViewController.handlePanGesture))
    }()

    private var presentedViewOriginalFrame: CGRect = .zero
    private var isShowingKeyboard = false
    private var startOrigin = CGPoint(x: 0, y: 0)
    private let edges: UIEdgeInsets
    private let sheetGestures: [UIGestureRecognizer]
    let viewController: UIViewController

    // MARK: - INITIALIZERS

    init(sheet: UIView,
         presenting: UIViewController,
         edges: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0),
         showIndicator: Bool = true) {
        self.edges = edges
        self.viewController = PresentedSheetViewController(sheet: sheet, showIndicator: showIndicator)
        self.sheetGestures = sheet.gestureRecognizers ?? []
        super.init(presentedViewController: viewController, presenting: presenting)
        viewController.transitioningDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeKeyboardObserver()
    }

    // MARK: - VIEWS

    private lazy var blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.alpha = 0
        return view
    }()

    // MARK: - PUBLIC METHODS

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        guard !isShowingKeyboard else { return }
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        addGestures()
        addBlurView()
        updateMargins()
        setupPresentedView()
        startBlurAnimation()
        addKeyboardObserver()
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        presentedViewOriginalFrame = presentedView?.frame ?? .zero
    }

    override func dismissalTransitionWillBegin() {
        stopBlurAnimation()
        delegate?.presentationControllerWillDismiss?(self)
    }

    // MARK: - PRIVATE METHODS

    private func addGestures() {
        blurView.addGestureRecognizer(tapGesture)
        presentedView?.addGestureRecognizer(panGesture)
        sheetGestures.forEach { panGesture.require(toFail: $0) }
    }

    private func addBlurView() {
        guard let containerView else { return }
        containerView.addSubview(blurView)
        blurView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }

    private func updateMargins() {
        let cell = presentedView?.subviews.first as? UIStackView
        cell?.layoutMargins = edges
        cell?.isLayoutMarginsRelativeArrangement = true
    }

    private func setupPresentedView() {
        presentedView?.layer.cornerRadius = 20
        presentedView?.layer.masksToBounds = true
        presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func startBlurAnimation() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurView.alpha = 1
        })
    }

    private func stopBlurAnimation() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurView.alpha = 0
        }, completion: { _ in
            self.blurView.removeFromSuperview()
        })
    }

    private func drag(to location: CGPoint) {
        if location.y > startOrigin.y {
            let movement = location.y - startOrigin.y
            let yPosition = presentedViewOriginalFrame.origin.y + movement
            presentedView?.frame.origin.y = yPosition
        }
    }

    private func dismiss() {
        presentedViewController.dismiss(animated: true) {
            self.delegate?.presentationControllerDidDismiss?(self)
        }
    }

    private func present() {
        guard let presented = presentedView else { return }
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self else { return }
                presented.frame = self.presentedViewOriginalFrame
            }
        )
    }

    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }

    private func getBottomSafeAreaHeight() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        return bottomPadding
    }

    @objc private func handleTapGesture() {
        dismiss()
    }

    @objc private func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        guard let view = pan.view, let superView = view.superview else { return }
        let location = pan.location(in: superView)
        let minHeight = presentedViewOriginalFrame.height / 4
        let remainingHeight = UIScreen.main.bounds.height - location.y

        switch pan.state {
        case .began:
            startOrigin = location

        case .changed:
            drag(to: location)

        case .ended:
            (remainingHeight < minHeight) ? dismiss() : present()

        default: break
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        presentedView?.removeGestureRecognizer(panGesture)
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height

        guard !isShowingKeyboard, let keyboardHeight else { return }

        isShowingKeyboard = true
        presentedView?.frame.size.height -= getBottomSafeAreaHeight()
        presentedView?.frame.origin.y -= (keyboardHeight - getBottomSafeAreaHeight())
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        isShowingKeyboard = false
        presentedView?.addGestureRecognizer(panGesture)
        presentedView?.frame = presentedViewOriginalFrame
        presentedView?.layoutIfNeeded()
    }
}

// MARK: - EXTENSIONS

extension BottomSheetViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return self
    }
}
