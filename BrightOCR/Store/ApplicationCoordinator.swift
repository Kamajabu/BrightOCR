//
//  ApplicationCoordinator.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    private let mainStore = MainStore()

    private let rootViewController: UINavigationController
    
    private unowned let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = false
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
