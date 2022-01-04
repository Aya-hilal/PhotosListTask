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
    static func create(photo: Photo?) -> BaseViewController {
        let photoDetailsView = PhotoDetailsViewController.instantiate(storyboardName: storyboardName)
        let viewModel = PhotoDetailsViewModel(photo: photo)
        photoDetailsView.viewModel = viewModel
        return photoDetailsView
    }
    
    
    //MARK: - IBOutlet and IBActions
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUIComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefaultNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Private Methods
    
    private func bindUIComponents() {
        guard let photo = viewModel.getPhoto() else {
            return
        }
        authorNameLabel.text = photo.author
        photoImageView.kf.indicatorType = .activity
        let photoImageUrl = URL(string: photo.downloadUrl)
        photoImageView.kf.setImage(with: photoImageUrl)
        self.view.backgroundColor = photoImageView.image?.getDominantColor()
        authorNameLabel.textColor = photoImageView.image?.getSecondaryColor()
        self.navigationController?.navigationBar.tintColor = photoImageView.image?.getSecondaryColor()
    }
}

