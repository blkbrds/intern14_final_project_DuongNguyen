//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let home = HomeViewController()
        let homeNaviVC = UINavigationController(rootViewController: home)
        homeNaviVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "ic-home"), selectedImage: #imageLiteral(resourceName: "ic-home"))

        let search = SearchViewController()
        let searchNaviVC = UINavigationController(rootViewController: search)
        searchNaviVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "ic-search"), selectedImage: #imageLiteral(resourceName: "ic-search"))

        let favorite = FavoriteViewController()
        let favoriteNaviVC = UINavigationController(rootViewController: favorite)
        favoriteNaviVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "ic-favorite"), selectedImage: #imageLiteral(resourceName: "ic-favorite"))

        let viewControllers = [homeNaviVC, searchNaviVC, favoriteNaviVC]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers

        UITabBar.appearance().tintColor = App.Color.selectedTintColor
//        UITabBarItem.set
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
