//
//  UIImage.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 04/01/2022.
//

import Foundation
import UIKit
import UIImageColors

extension UIImage {
    func getDominantColor() -> UIColor? {
        let colors = self.getColors()
        return colors?.primary
    }
    
    func getSecondaryColor() -> UIColor? {
        let colors = self.getColors()
        return colors?.secondary
    }
}
