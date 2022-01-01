//
//  BaseViewModel.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import TTGSnackbar

class BaseViewModel {
    static let networkMessageKey: String = "NetworkMessage"

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewModel.showSnackBar(notification:)), name: Notification.Name(BaseViewModel.networkMessageKey), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(BaseViewModel.networkMessageKey), object: nil)
    }
    
    @objc func showSnackBar(notification: NSNotification) {
        if let message = notification.object as? String {
            showSnackBar(message: message)
            
        }
    }
    func showSnackBar(message: String) {
        DispatchQueue.main.async {
            let snackbar = TTGSnackbar(message: message, duration: .middle)
            snackbar.show()
        }
    }
}
