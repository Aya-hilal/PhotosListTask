//
//  PhotoDetailsViewController.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 03/01/2022.
//

import Foundation
import UIKit

class PhotoDetailsViewController: BaseViewController, Alertable, Storyboarded  {
    
    //MARK: - Propertires
    private var viewModel: PhotoDetailsViewModel!
    
    //MARK: - Navigation
    static let storyboardName: String = "PhotoDetails"
    static func create() -> BaseViewController {
        let photoDetailsView = PhotoDetailsViewController.instantiate(storyboardName: storyboardName)
        let viewModel = PhotoDetailsViewModel()
        photoDetailsView.viewModel = viewModel
        return photoDetailsView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
}

