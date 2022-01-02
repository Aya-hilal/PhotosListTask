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

    //MARK: - Navigation
    static let storyboardName: String = "PhotosList"
    static func create() -> BaseViewController {
        let moviesListView = PhotosListViewController.instantiate(storyboardName: storyboardName)
        let viewModel = PhotosListViewModel()
        moviesListView.viewModel = viewModel
        return moviesListView
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
    
    private func fetchPhotosRemotly() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.startFetchingPhotosList()
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupDataSource() {
       dataSource = PhotosListDataSource(tableView: photosTableView, viewController: self, onItemSelected: onPhotoItemSelected, onLoadMorePhotos: onLoadMorePhotos)
    }
    
    private func onPhotoItemSelected(photo: Photo?) {
        
    }
    
    private func onLoadMorePhotos() {
        dataSource.displaySkeletonView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.loadMorePhotos()
        }
    }
    
    private func observeToViewModelChanges() {
        viewModel.photosList.observe(on: self) { photos in
            if photos?.isEmpty ?? true {
                return
            }
            self.dataSource.updatePhotosList(photos ?? [], fromPagination: self.viewModel.getFromPagination(), canFetchMorePhotos: self.viewModel.getCanFetchMorePhotos())
        }
    }

}
