//
//  UIImageView+Extension.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 12/01/22.
//

import UIKit
import Kingfisher
extension UIImageView {
    func loadImage(with urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { backgroundColor = .lightText; return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, options: [.cacheOriginalImage])
    }
}
