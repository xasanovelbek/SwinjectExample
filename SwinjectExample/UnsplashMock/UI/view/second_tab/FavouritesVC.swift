//
//  FavouritesVC.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import UIKit

import Combine
class FavouritesVC: BaseViewController {
    
    static let TAG = "PicturesVC"
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor._light_green
        return view
    }()
    
    
    
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.configureImageLayout(self.view.frame.width, 16.0)
        
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.TAG)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    

    
    var pictures = [PictureModel]() {
        didSet {
            self.mainCollectionView.reloadData()
        }
    }
    
    var favouritesViewModel: FavouritesViewModel?
    
    
    var currentPage = 0
    
    var cancellables = Set<AnyCancellable>()

    
    override func setupViews() {
        self.title = "Favourite pictures"
        
        
        self.view.addSubview(mainContainer)
        self.mainContainer.addSubview(mainCollectionView)
        self.view.layoutIfNeeded()
        super.setupIndicator(container: mainContainer)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainContainerConstraints()
        mainCollectionViewConstraints()
    }
    
    override func setupBindings() {
        
        favouritesViewModel?
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        favouritesViewModel?
            .$error
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                self.currentPage -= 1
                self.showError(error ?? "")
            }
            .store(in: &cancellables)
        
        favouritesViewModel?
            .$favourites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self = self else { return }
                self.pictures = response ?? []
            }
            .store(in: &cancellables)
    }
    
    override func loadDatas() {
        favouritesViewModel?.loadFavourites()
    }
    
    
    
}

extension FavouritesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.TAG, for: indexPath) as! PictureCell
        cell.configure(with: self.pictures[indexPath.row])
        return cell
    }
    
    

    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PictureDatasVC()
        vc.pictureModel = self.pictures[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clicked() {
        currentPage += 1
        loadDatas()
    }
    
}



//constraints
extension FavouritesVC {
    
    
    private func mainCollectionViewConstraints() {
        mainCollectionView.topAnchor.constraint(equalTo: self.mainContainer.topAnchor).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: self.mainContainer.leadingAnchor).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: self.mainContainer.trailingAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: self.mainContainer.bottomAnchor).isActive = true
    }
    
    private func mainContainerConstraints() {
        mainContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

