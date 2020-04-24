//
//  BelowMenuContentViewController.swift
//  spotter
//
//  Created by Mark Anthony Molina on 23/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import UIKit
import FloatingPanel

private protocol FloatingMenuProtocol {
    
    var floatingPanelController: FloatingPanelController { get }
    var tapRecognizer: UITapGestureRecognizer { get }
}

extension BelowMenuContentViewController {
    
    @objc private func menuTapped(recognizer: UITapGestureRecognizer) {
        
        switch floatingPanelController.position {
        case .full:
            fallthrough
        case .tip:
            floatingPanelController.move(to: .half, animated: true)
        case .half:
            fallthrough
        case .hidden:
            fallthrough
        default:
            floatingPanelController.move(to: .tip, animated: true)
        }
    }
}

class BelowMenuContentViewController: UIViewController, FloatingPanelControllerDelegate {
    
    private let floatingPanelController = FloatingPanelController()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(menuTapped(recognizer:)))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Remove the views managed by the `FloatingPanelController` object from self.view.
        floatingPanelController.removePanelFromParent(animated: true)
    }
    
    private func setupViews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let menuViewController = MenuViewController()
        menuViewController.view.addGestureRecognizer(tapRecognizer)
        floatingPanelController.delegate = self
        floatingPanelController.set(contentViewController: menuViewController)
        present(floatingPanelController, animated: true, completion: nil)
    }
}
