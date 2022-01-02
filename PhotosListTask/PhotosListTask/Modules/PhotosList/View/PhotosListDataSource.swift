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
    private var onLoadMorePhotos: (() -> Void)!
    private var photosList: [Photo] = []
    private var canFetchMorePhotos: Bool = true
    
    init(tableView: UITableView, viewController: BaseViewController, onItemSelected: @escaping ((_:Photo?) -> Void), onLoadMorePhotos: @escaping (() -> Void)) {
        super.init()
        self.tableView = tableView
        self.viewController = viewController
        self.onPhotoItemSelected = onItemSelected
        self.onLoadMorePhotos = onLoadMorePhotos
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let photoCell = UINib(nibName: PhotoCell.ID, bundle: nil)

        tableView.register(photoCell,
                           forCellReuseIdentifier: PhotoCell.ID)
    }
    
    func updatePhotosList(_ photosList: [Photo], fromPagination: Bool, canFetchMorePhotos: Bool) {
        if fromPagination {
            self.photosList.append(contentsOf: photosList)
        } else {
            self.photosList = photosList
        }
        self.canFetchMorePhotos = canFetchMorePhotos
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == photosList.count - 1 && canFetchMorePhotos {
            onLoadMorePhotos()
        }
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
