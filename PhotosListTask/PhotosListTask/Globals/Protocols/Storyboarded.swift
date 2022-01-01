//
//  Storyboarded.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import UIKit

protocol Storyboarded: NSObject {

    static func instantiate(storyboardName: String) -> Self
    
    static var storyboardName: String { get }
    
}

extension Storyboarded where Self: UIViewController {

    static func instantiate(storyboardName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: id) as? Self
        return view ?? Self()
    }

}
