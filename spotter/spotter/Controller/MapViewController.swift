//
//  MapViewController.swift
//  spotter
//
//  Created by Mark Anthony Molina on 23/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import UIKit
import FloatingPanel
import GoogleMaps

private let MENU_CLOSED_OFFSET: CGFloat = 80
private let MENU_OPEN_OFFSET: CGFloat = 440

class MapViewController: UIViewController, FloatingPanelControllerDelegate {
    
    private let floatingPanelController = FloatingPanelController()
    
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
        
        let mapView = GMSMapView(frame: view.frame)
        view.addSubview(mapView)
        
        let menuViewController = MenuViewController()
        floatingPanelController.delegate = self

        floatingPanelController.set(contentViewController: menuViewController)
        floatingPanelController.addPanel(toParent: self)
    }
    
    private func closedOffset() -> CGFloat {
        return view.frame.height - MENU_CLOSED_OFFSET
    }
    
}
