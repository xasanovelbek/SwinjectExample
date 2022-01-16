//
//  CollectionFooter.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import UIKit


class CollectionFooter: UICollectionReusableView {
    
    static let TAG = "CollectionFooter"
    
    
    lazy var loadMoreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Load more", for: .normal)
        button.setTitle("Loading", for: .disabled)
        button.backgroundColor = UIColor._green
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16.0
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loadMoreButton)
        self.backgroundColor = .clear
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        loadMoreButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        loadMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
        
        loadMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        loadMoreButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
    }
    
 
    
    
}
