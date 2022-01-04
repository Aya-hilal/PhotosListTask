//
//  PhotoCell.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import UIKit
import Kingfisher
import SkeletonView

class PhotoCell: UITableViewCell {
    
    static let ID = String(describing: PhotoCell.self)
    private var onPhotoItemSelected: ((Photo?, UIImage?) -> Void)!
    private var photoItem: Photo?
    
    //MARK: - IBOutlet and IBActions
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    private func setupCell() {
        selectionStyle = .none
    }
    func bindCell(photo: Photo, onPhotoItemSelected: @escaping ((_:Photo?, UIImage?) -> Void)) {
        self.photoItem = photo
        addImageGesture()
        authorNameLabel.text = photo.author
        let photoImageUrl = URL(string: photo.downloadUrl)
        photoImageView.kf.setImage(with: photoImageUrl)
        self.onPhotoItemSelected = onPhotoItemSelected
    }
    
    private func addImageGesture() {
        self.photoImageView.isUserInteractionEnabled = true
        let gesutre = UITapGestureRecognizer(target: self, action: #selector(onImageSelected))
        self.photoImageView.addGestureRecognizer(gesutre)
    }
    
    @objc private func onImageSelected() {
        onPhotoItemSelected(photoItem, photoImageView.image)
    }
    
}
