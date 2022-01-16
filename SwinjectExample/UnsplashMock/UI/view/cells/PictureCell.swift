//
//  PictureCell.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    static let TAG = "PictureCell"

    
    
    private lazy var contentImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 32
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var datasContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor._pink.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var heartIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = UIColor._light_red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    func initViews() {
        self.layer.cornerRadius = 32
        self.clipsToBounds = true
        
        self.addSubview(contentImage)
        
        self.addSubview(datasContainer)
        self.datasContainer.addSubview(nameLabel)
        self.datasContainer.addSubview(heartIcon)
        self.layoutIfNeeded()
    }
    
    private func configureConstraints() {
        let margin: CGFloat = 8.0
        contentImage.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        contentImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin).isActive = true
        contentImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: margin).isActive = true
        contentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -margin).isActive = true
        
        datasContainer.bottomAnchor.constraint(equalTo: self.contentImage.bottomAnchor).isActive = true
        datasContainer.trailingAnchor.constraint(equalTo: self.contentImage.trailingAnchor).isActive = true
        datasContainer.leadingAnchor.constraint(equalTo: self.contentImage.leadingAnchor).isActive = true
        datasContainer.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        heartIcon.leadingAnchor.constraint(equalTo: self.datasContainer.leadingAnchor, constant: 16.0).isActive = true
        heartIcon.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
        heartIcon.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        heartIcon.centerYAnchor.constraint(equalTo: datasContainer.centerYAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: datasContainer.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: datasContainer.bottomAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: datasContainer.trailingAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: heartIcon.trailingAnchor, constant: 16).isActive = true
    }
 
    
    func configure(with model: PictureModel) {
        print(model)
        contentImage.loadImage(with: model.urls?.regular)
        nameLabel.text = "\(model.likes ?? 0)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        contentImage.image = nil
        nameLabel.text = ""
    }
}
