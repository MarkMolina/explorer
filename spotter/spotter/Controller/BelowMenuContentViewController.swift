//
//  BelowMenuContentViewController.swift
//  spotter
//
//  Created by Mark Anthony Molina on 23/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import UIKit
import FloatingPanel

protocol FloatingMenuProtocol {
    
//    var floatingPanelController: FloatingPanelController { get }
    var bottomMargin: CGFloat { get }
}

private let TIP: CGFloat = 44.0
private let HALF_OPEN: CGFloat = 216.0

class BelowMenuContentViewController: UIViewController, FloatingMenuProtocol {
    
    let bottomMargin: CGFloat = TIP
    
    private let floatingPanelController = FloatingPanelController()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(menuTapped(recognizer:)))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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

extension BelowMenuContentViewController: FloatingPanelControllerDelegate {
    
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
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return CustomFloatingPanelLayout(positions: (half: HALF_OPEN, tip: bottomMargin))
    }
}

class CustomFloatingPanelLayout: FloatingPanelLayout {
    
    let positions: (half: CGFloat, tip: CGFloat)
    
    init(positions: (half: CGFloat, tip: CGFloat)) {
        self.positions = positions
    }
    
    public var initialPosition: FloatingPanelPosition {
        return .tip
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
            case .full: return 16.0 // A top inset from safe area
        case .half: return positions.half // A bottom inset from the safe area
        case .tip: return positions.tip // A bottom inset from the safe area
            default: return nil // Or `case .hidden: return nil`
        }
    }
}
