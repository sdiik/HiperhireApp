//
//  NavigationExtension.swift
//  HyperhireApp
//
//  Created by ahmad shiddiq on 06/12/24.
//

import Foundation
import UIKit

func showNavigationBar(controller: UIViewController) -> UINavigationController {
    let navController = UINavigationController(rootViewController: controller)
    navController.navigationBar.barTintColor = Colors.tab
    navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navController.navigationBar.backgroundColor =  Colors.tabBackground
    navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navController.navigationBar.shadowImage = UIImage()
    return navController
}

