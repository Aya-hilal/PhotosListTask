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
    private var currentlyLoadMorePhotos: Bool = false
    
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
        tableView.estimatedRowHeight = 300

        let photoCell = UINib(nibName: PhotoCell.ID, bundle: nil)
        let skeletonPhotoCell = UINib(nibName: SkeletonPhotoCell.ID, bundle: nil)

        tableView.register(photoCell,
                           forCellReuseIdentifier: PhotoCell.ID)
        tableView.register(skeletonPhotoCell,
                           forCellReuseIdentifier: SkeletonPhotoCell.ID)
        tableView.reloadData()
    }
    
    func updatePhotosList(_ photosList: [Photo], fromPagination: Bool, canFetchMorePhotos: Bool) {
        currentlyLoadMorePhotos = false
        if fromPagination {
            self.photosList.append(contentsOf: photosList)
        } else {
            self.photosList = photosList
        }
        self.canFetchMorePhotos = canFetchMorePhotos
        self.tableView.reloadData()
    }
    
    func displaySkeletonView() {
        currentlyLoadMorePhotos = true
        tableView.reloadData()
    }
}


extension PhotosListDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if photosList.isEmpty {
            return 3
        }
        if currentlyLoadMorePhotos {
            return photosList.count + 3
        }
        return photosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if photosList.isEmpty || (!photosList.isEmpty && currentlyLoadMorePhotos && indexPath.row >= photosList.count){
            return instantiateSkeletonPhotoCell()
        }
        return instantiatePhotoCell(photo: photosList[indexPath.row])
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if tableView.visibleCells.contains(cell) {
                if indexPath.row == self.photosList.count - 1 && self.canFetchMorePhotos && !self.photosList.isEmpty && !self.currentlyLoadMorePhotos {
                        self.onLoadMorePhotos()
                }
            }
        }
    }
    
    
    private func instantiatePhotoCell(photo: Photo) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.ID) as? PhotoCell else {
            return UITableViewCell()
        }
        cell.bindCell(photo: photo)
        return cell
    }
    
    private func instantiateSkeletonPhotoCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonPhotoCell.ID) as? SkeletonPhotoCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onPhotoItemSelected(photosList[indexPath.row])
    }
}
