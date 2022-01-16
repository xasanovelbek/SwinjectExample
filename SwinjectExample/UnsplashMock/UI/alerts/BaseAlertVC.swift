//
//  BaseAlertVC.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 13/01/22.
//

import UIKit


class BaseAlertVC: UIViewController {
    
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 32
        view.backgroundColor = ._light_red
        return view
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = ._light_gray
        imageView.image = UIImage(named: "error")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var dissmissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        button.layer.cornerRadius = 28
        button.backgroundColor = ._yellow
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissClick), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    var errorText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.view.addSubview(container)
        self.container.addSubview(image)
        self.container.addSubview(titleLabel)
        self.container.addSubview(dissmissButton)
        self.view.layoutIfNeeded()
        
        titleLabel.text = errorText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    @objc func dismissClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        container.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        image.topAnchor.constraint(equalTo: container.topAnchor, constant: 32).isActive = true
        image.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: dissmissButton.topAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        
        
        dissmissButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -32).isActive = true
        dissmissButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        dissmissButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dissmissButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
    


    

}
