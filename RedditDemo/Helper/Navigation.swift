//
//  Navigation.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import Foundation
import UIKit

class Navigation: NSObject {
    // MARK: - Helpers
    
    static func getRootViewController() -> UIViewController? {
        var rootViewController: UIViewController?
        if #available(iOS 13.0, *) {
            // iOS 13 (or newer) Swift code
            rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        } else {
            // iOS older code
            rootViewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        return rootViewController
    }
    
    public static func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }
        
        return rootViewController
    }
    
    //MARK: - Actions
    
    static func navigateFullScreen(in navigationController: UINavigationController,_ url : String? = nil) -> Void {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: UIStoryboard.main, bundle: nil)
            let controller = storyboard.instantiateViewController(identifier: UIViewController.fullScreenController) as FullScreenController
            controller.modalPresentationStyle = .fullScreen
            controller.dataSource.imageURL  = url
            navigationController.show(controller, sender: nil)
        }
    }
}
