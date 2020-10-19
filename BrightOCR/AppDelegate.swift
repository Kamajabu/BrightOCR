//
//  AppDelegate.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)

        self.window = window
        self.applicationCoordinator = applicationCoordinator

        applicationCoordinator.start()
        return true
    }

}
