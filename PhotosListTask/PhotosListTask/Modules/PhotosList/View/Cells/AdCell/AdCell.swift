//
//  AdCell.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 03/01/2022.
//

import Foundation
import UIKit

class AdCell: UITableViewCell {
    
    static let ID = String(describing: AdCell.self)
        
    //MARK: - Methods
     override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        selectionStyle = .none
    }
    
}
