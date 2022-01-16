//
//  BaseViewController.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import UIKit


class BaseViewController: UIViewController {

    var viewModel: BaseViewModel?
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .red
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        loadDatas()
    }

    
    func setupViews() {}

    func setupBindings() {}

    func loadDatas() {}

    func setupIndicator(container: UIView) {
        container.addSubview(indicator)
        indicator.center = container.center
    }
    
    func showError(_ text: String) {
        
        let alert = BaseAlertVC()
        alert.errorText = text
        alert.modalTransitionStyle = .flipHorizontal
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: true, completion: nil)
    }
}
