//
//  CNLoginViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 24/09/23.
//

import UIKit

protocol CNLoginViewControllerDelegate: AnyObject { }

final class CNLoginViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    weak var delegate: CNLoginViewControllerDelegate?
    private let viewModel: CNLoginViewModel
    private let contentView: CNLoginView
    
    // MARK: - INITIALIZERS
    
    init(viewModel: CNLoginViewModel,
         contentView: CNLoginView = CNLoginView()) {
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        viewModel.start()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupController() {
        viewModel.delegate = self
        contentView.delegate = self
        view = contentView
    }
}

// MARK: - EXTENSIONS

extension CNLoginViewController: CNLoginViewModelDelegate {
    func updateState(with viewState: CNLoginViewState) {
        contentView.updateView(with: viewState)
    }
}

extension CNLoginViewController: CNLoginViewDelegate { }
