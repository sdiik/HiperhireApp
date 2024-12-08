//
//  TabBarViewController.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 06/12/24.
//


import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationControllers()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.colorView
        tabBar.tintColor = Colors.tab
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [TabBarViewController.self])
        appearance.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: Colors.tab as Any],
            for: .normal)
        appearance.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: Colors.tabSelected as Any],
            for: .selected)
    }
    
    private func setupNavigationControllers() {
        viewControllers = [
            createNavController(
                for: UIViewController(),
                title: .home,
                image: UIImage(named: "Home")!,
                imageSelected: UIImage(named: "Home")!
            ),
            createNavController(
                for: UIViewController(),
                title: .search,
                image: UIImage(named: "Search")!,
                imageSelected: UIImage(named: "Search")!
            ),
            createNavController(
                for: LibraryViewController(),
                title: .library,
                image: UIImage(named: "Library")!,
                imageSelected: UIImage(named: "Library")!
            )
        ]
    }
    
    fileprivate func createNavController(
        for rootViewController: UIViewController,
        title: tabBarType,
        image: UIImage,
        imageSelected: UIImage
    ) -> UIViewController {
        let navController = showNavigationBar(controller: rootViewController)
        navController.tabBarItem.title = title.tabTitle
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = imageSelected
        rootViewController.navigationItem.title = title.navigationTitle
        return navController
    }
}
