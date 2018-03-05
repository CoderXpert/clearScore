//
//  AppDelegate.swift
//  ClearScore
//
//  Created by luca silvestro on 03/03/18.
//  Copyright © 2018 Clear Score. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barStyle = .blackOpaque
        let rootWireframe = ScoreGraphWireframe(window: window)
        rootWireframe.show(with: .root)
        
        return true
    }
}

