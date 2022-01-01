//
//  BaseViewController.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var activityView: UIActivityIndicatorView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeActivityIndicatorStatus(show: Bool) {
        if show {
            if #available(iOS 13.0, *) {
                activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            } else {
                activityView = UIActivityIndicatorView(style: .whiteLarge)
            }
            activityView?.style = UIActivityIndicatorView.Style.large
            activityView?.color = .gray
        //MARK: - Center loader with respect to window not super view
        let window = UIApplication.shared.keyWindow!
        activityView?.center =  window.center
        window.addSubview(activityView!)
        window.bringSubviewToFront(activityView!)
        activityView?.startAnimating()
        } else {
            if (activityView != nil){
                activityView?.stopAnimating()
            }
        }
        self.view.isUserInteractionEnabled = !show
    }
}
