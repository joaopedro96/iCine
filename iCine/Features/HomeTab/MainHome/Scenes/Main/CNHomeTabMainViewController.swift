//
//  CNHomeTabMainViewController.swift
//  iCine
//
//  Created by João Pedro Mata on 29/01/24.
//

import UIKit

protocol CNHomeTabMainViewControllerDelegate: AnyObject {
    func goToFavoritesTab()
}

final class CNHomeTabMainViewController: UIViewController {
    
    weak var flowDelegate: CNHomeTabMainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    @objc private func didTapView() {
        flowDelegate?.goToFavoritesTab()
    }
}

