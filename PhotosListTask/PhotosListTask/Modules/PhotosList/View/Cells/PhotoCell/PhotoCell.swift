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
    func bindCell(photo: Photo) {
        authorNameLabel.text = photo.author
        let photoImageUrl = URL(string: photo.downloadUrl)
        photoImageView.kf.setImage(with: photoImageUrl)
    }
    
}
