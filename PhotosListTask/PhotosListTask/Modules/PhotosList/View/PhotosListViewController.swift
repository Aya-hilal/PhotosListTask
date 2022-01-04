//
//  PhotosListView.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 01/01/2022.
//

import Foundation
import UIKit

class PhotosListViewController: BaseViewController, Alertable, Storyboarded  {
    
    //MARK: - Propertires
    private var viewModel: PhotosListViewModel!
    private var dataSource: PhotosListDataSource!
    private var refreshControl = UIRefreshControl()

    //MARK: - Navigation
    static let storyboardName: String = "PhotosList"
    static func create() -> BaseViewController {
        let photosListView = PhotosListViewController.instantiate(storyboardName: storyboardName)
        let viewModel = PhotosListViewModel()
        photosListView.viewModel = viewModel
        return photosListView
    }
    
    //MARK: - IBOutlet and IBActions
    
    @IBOutlet weak var photosTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        fetchPhotosRemotly()
        observeToViewModelChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupSwipeToRefresh() {
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(refreshPhotosList), for: .valueChanged)
        photosTableView.refreshControl = refreshControl
        photosTableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
    }

    @objc private func refreshPhotosList() {
        refreshControl.beginRefreshing()
        fetchPhotosRemotly()
    }
    
    private func fetchPhotosRemotly() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.startFetchingPhotosList()
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupDataSource() {
        dataSource = PhotosListDataSource(tableView: photosTableView, viewController: self, onItemSelected: onPhotoItemSelected, onLoadMorePhotos: onLoadMorePhotos, onAllItemSelected: onItemSelected)
        setupSwipeToRefresh()
    }
    
    private func onPhotoItemSelected(photo: Photo?, image: UIImage?) {
        if photo?.downloadUrl != "" && image != nil {
            openImageInFullScreen(image: image!)
        }
    }
    
    private func onItemSelected(photo: Photo?) {
        if photo?.type == .ad {
            return
        }
        NavigationManager.sharedInstance.openPhotoDetails(parentview: self, photo: photo)
    }
    
    private func openImageInFullScreen(image: UIImage) {
           let newImageView = UIImageView(image: image)
           newImageView.frame = UIScreen.main.bounds
           newImageView.backgroundColor = .black
           newImageView.contentMode = .scaleAspectFit
           newImageView.isUserInteractionEnabled = true
           let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
           newImageView.addGestureRecognizer(tap)
           self.view.addSubview(newImageView)
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    private func onLoadMorePhotos() {
        dataSource.displaySkeletonView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.loadMorePhotos()
        }
    }
    
    private func observeToViewModelChanges() {
        viewModel.photosList.observe(on: self) { photos in
            self.refreshControl.endRefreshing()
            if photos?.isEmpty ?? true {
                return
            }
            let photoWithAdsList = self.getPhotosWithAdsList(photos: photos ?? [])
            self.dataSource.updatePhotosList(photoWithAdsList, fromPagination: self.viewModel.getFromPagination(), canFetchMorePhotos: self.viewModel.getCanFetchMorePhotos())
        }
    }
    
    private func getPhotosWithAdsList(photos: [Photo]) -> [Photo] {
        var result: [Photo] = []
        for index in 0..<(photos.count) {
            result.append(photos[index])
           if (index+1) % 5 == 0 {
               result.append(Photo(type: .ad))
           }
        }
        return result
    }

}
