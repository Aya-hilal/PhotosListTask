//
//  PhotosListDataSource.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import UIKit

class PhotosListDataSource: NSObject {
    
    private var tableView: UITableView!
    private var viewController: BaseViewController!
    private var onPhotoItemSelected: ((Photo?) -> Void)!
    private var photosList: [Photo] = []
    
    init(tableView: UITableView, viewController: BaseViewController, onItemSelected: @escaping ((_:Photo?) -> Void)) {
        super.init()
        self.tableView = tableView
        self.viewController = viewController
        self.onPhotoItemSelected = onItemSelected
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let photoCell = UINib(nibName: PhotoCell.ID, bundle: nil)

        tableView.register(photoCell,
                           forCellReuseIdentifier: PhotoCell.ID)
    }
    
    func bindPhotosList(_ photosList: [Photo]) {
        self.photosList = photosList
        self.tableView.reloadData()
    }
    
}


extension PhotosListDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if photosList.count > 0 {
          return instantiatePhotoCell(photo: photosList[indexPath.row])
        }
        return UITableViewCell()
    }
    
    private func instantiatePhotoCell(photo: Photo) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.ID) as? PhotoCell else {
            return UITableViewCell()
        }
        cell.bindCell(photo: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onPhotoItemSelected(photosList[indexPath.row])
    }
}
