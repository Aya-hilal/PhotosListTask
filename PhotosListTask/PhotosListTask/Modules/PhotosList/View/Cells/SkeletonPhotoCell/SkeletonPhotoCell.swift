//
//  SkeletonPhotoCell.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 03/01/2022.
//

import Foundation
import UIKit
import Kingfisher
import SkeletonView

class SkeletonPhotoCell: UITableViewCell {
    
    static let ID = String(describing: SkeletonPhotoCell.self)
    
    @IBOutlet weak var skeletonImageView: UIImageView!
    @IBOutlet weak var skeletonLabel: UILabel!
    
    //MARK: - Methods
     override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        selectionStyle = .none
        skeletonLabel.showAnimatedGradientSkeleton()
        skeletonImageView.showAnimatedGradientSkeleton()
    }
    
}
