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
    private let resultsListCoordinator: ResultsListCoordinator

    private unowned let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = false
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.adaptedColor(light: .prussianBlue, dark: .white)
        navigationBarAppearace.barTintColor = UIColor.barBackground
        
        resultsListCoordinator = ResultsListCoordinator(parentViewController: rootViewController, mainStore: mainStore)
        resultsListCoordinator.start()
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
