//
//  NavigationManager.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import UIKit

class NavigationManager {
    
    static let sharedInstance = NavigationManager()

    private func openView(parentview: BaseViewController?, targetView: BaseViewController, returnNavigationController: Bool) {
        guard let parentview = parentview else {
            let navigationController = BaseNavigationController(rootViewController: targetView)
            navigationController.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            return
        }
        if returnNavigationController {
            let navigationController = BaseNavigationController(rootViewController: targetView)
            navigationController.modalPresentationStyle = .fullScreen
            parentview.present(navigationController, animated: true, completion: nil)
        } else {
            guard let navigationController = parentview.navigationController else {
                return
            }
            navigationController.pushViewController(targetView, animated: true)
        }
    }
}

// UIScreens
extension NavigationManager {
    //MARK :- Photo details screen
    func openPhotoDetails(parentview: BaseViewController?, photo: Photo?) {
        let photoDetailsVC = PhotoDetailsViewController.create(photo: photo)
        openView(parentview: parentview, targetView: photoDetailsVC, returnNavigationController: false)
    }
    
}
