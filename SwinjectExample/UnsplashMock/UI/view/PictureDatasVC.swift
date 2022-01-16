//
//  PictureDatasVC.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import UIKit
import Combine

class PictureDatasVC: BaseViewController {
    
    static let TAG = "PictureDatasVC"
    
    lazy var mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor._light_peach
        return view
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightText
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Users name:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Created at:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Downloaded location:\n\n"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var seenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total downloads:"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(seenLabel)
        return stackView
    }()
    
    lazy var nameDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var dateDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var locationDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var seenDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()
    

    
    lazy var labelsDatasStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.addArrangedSubview(nameDataLabel)
        stackView.addArrangedSubview(dateDataLabel)
        stackView.addArrangedSubview(locationDataLabel)
        stackView.addArrangedSubview(seenDataLabel)
        return stackView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor._green
        button.setTitle("Save to favourite", for: .normal)
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Remove from favourite", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor._light_red
        return button
    }()
    
    var pictureModel: PictureModel?
    
    var favouriteViewModel = FavouritesViewModel.shared
    
    var cancellables = Set<AnyCancellable>()
    
    override func setupViews() {
        self.view.addSubview(mainContainer)
        self.mainContainer.addSubview(contentImageView)
        self.mainContainer.addSubview(labelsStackView)
        self.mainContainer.addSubview(labelsDatasStackView)
        self.mainContainer.addSubview(saveButton)
        self.mainContainer.addSubview(removeButton)
        
        self.view.layoutIfNeeded()
        
        addTargets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainContainerConstraints()
        contentImageViewConstraints()
        stackViewsContraints()
        buttonsContraints()
    }
    
    override func setupBindings() {
        favouriteViewModel
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                isLoading ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        favouriteViewModel
            .$error
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.saveButton.shake()
                self?.removeButton.shake()
                self?.showError(error ?? "")
            }
            .store(in: &cancellables)
    }
    
    override func loadDatas() {
        self.contentImageView.loadImage(with: pictureModel?.urls?.regular)
        
        self.nameDataLabel.text = pictureModel?.user?.name
        self.dateDataLabel.text = pictureModel?.created_at?.formatDate()
        self.locationDataLabel.text = pictureModel?.links?.download_location
        self.seenDataLabel.text = "\(pictureModel?.user?.total_photos ?? 1)"
    }
    
    private func addTargets() {
        saveButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        sender.pulse{ }
        
        if sender == saveButton {
            if let pictureModel = pictureModel {
                favouriteViewModel.addToFavouritePicture(picture: pictureModel)
            }
        } else {
            if let pictureModel = pictureModel {
                favouriteViewModel.removeFavouritePicture(picture: pictureModel)
            }
        }
    }
}

//constraints
extension PictureDatasVC {
    private func mainContainerConstraints() {
        mainContainer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    private func contentImageViewConstraints() {
        contentImageView.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 32).isActive = true
        contentImageView.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor).isActive = true
        contentImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        contentImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func stackViewsContraints() {
        
        labelsStackView.topAnchor.constraint(equalTo: contentImageView.bottomAnchor,
                                             constant:  16).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 16).isActive = true
        labelsStackView.widthAnchor.constraint(equalToConstant: (self.view.frame.width / 2) - 16.0).isActive = true
        
        labelsDatasStackView.topAnchor.constraint(equalTo: contentImageView.bottomAnchor,
                                                  constant:  16).isActive = true
        labelsDatasStackView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor,constant: -16).isActive = true
        labelsDatasStackView.widthAnchor.constraint(equalToConstant: (self.view.frame.width / 2) - 16.0).isActive = true
        
        labelsDatasStackView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        labelsStackView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
    }
    
    private func buttonsContraints() {
        saveButton.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: contentImageView.trailingAnchor).isActive = true
        
        
        
        removeButton.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor).isActive = true
        removeButton.trailingAnchor.constraint(equalTo: contentImageView.trailingAnchor).isActive = true
        removeButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -16).isActive = true
        
        saveButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        removeButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
}
