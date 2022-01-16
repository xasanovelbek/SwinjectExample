//
//  PicturesVC.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import UIKit
import Combine
class PicturesVC: BaseViewController, UITextFieldDelegate {
    
    static let TAG = "PicturesVC"
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor._yellow
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "search smth"
        textField.backgroundColor = .lightGray
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.returnKeyType = .search
        textField.backgroundColor = UIColor._light_gray
        
        return textField
    }()
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.configureImageLayout(self.view.frame.width, 16.0)
        
        
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.TAG)
        collectionView.register(CollectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooter.TAG)
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
    
    var picturesViewModel: PicturesViewModel?
    var currentPage = 1
    var searchLastPage = 1
    var cancellables = Set<AnyCancellable>()
    

    override func setupViews() {
        self.title = "World of pictures"
        self.view.addSubview(mainContainer)
        self.mainContainer.addSubview(searchTextField)
        self.mainContainer.addSubview(mainCollectionView)
        self.view.layoutIfNeeded()
        super.setupIndicator(container: mainContainer)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainContainerConstraints()
        searchTextFieldConstraints()
        mainCollectionViewConstraints()
    }
    
    override func setupBindings() {
        picturesViewModel?
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        picturesViewModel?
            .$error
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] error in
                guard let self = self else { return }
                self.currentPage -= 1
                self.showError(error ?? "")
            }
            .store(in: &cancellables)
        
        picturesViewModel?
            .$pictures
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self = self else { return }
                self.pictures.append(contentsOf: response)
            }
            .store(in: &cancellables)
        
        picturesViewModel?
            .$searchResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchResultModel in
                guard let self = self else { return }
                self.pictures.append(contentsOf: searchResultModel?.results ?? [])
                self.searchLastPage = searchResultModel?.total_pages ?? 1
            }
            .store(in: &cancellables)
    }
    
    
    
    override func loadDatas() {
        if !(viewModel?.isLoading ?? false) {
            picturesViewModel?.getPictures(currentPage)
        }
    }
    
    private func search() {
        if (searchTextField.text ?? "") != "" {
            picturesViewModel?.searchPictures(currentPage, q: searchTextField.text ?? "")
        } else {
            loadDatas()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.pictures = []
        self.currentPage = 1
        search()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension PicturesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.TAG, for: indexPath) as! PictureCell
        cell.configure(with: self.pictures[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let footer: CollectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooter.TAG, for: indexPath) as! CollectionFooter
        footer.loadMoreButton.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if !self.pictures.isEmpty {
            return CGSize(width: collectionView.frame.width, height: 80)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.pulse { [weak self] in
            guard let vc = Assembler.sharedAssembler.resolver.resolve(PictureDatasVC.self, argument: self?.pictures[indexPath.row]) else { return }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.displayAnimation()
    }
    
    @objc func clicked() {
        currentPage += 1
        if (searchTextField.text ?? "") != "" {
            search()
        } else {
            loadDatas()
        }
    }
    
}



//constraints
extension PicturesVC {
    private func searchTextFieldConstraints() {
        searchTextField.topAnchor.constraint(equalTo: self.mainContainer.topAnchor, constant: 16).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: self.mainContainer.leadingAnchor, constant: 16).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: self.mainContainer.trailingAnchor, constant: -16).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    private func mainCollectionViewConstraints() {
        mainCollectionView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 16).isActive = true
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

