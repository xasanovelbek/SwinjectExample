//
//  UICollectionView+Extension.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 13/01/22.
//

import UIKit
extension UICollectionViewFlowLayout {
    func configureImageLayout(_ width: CGFloat, _ margin: CGFloat) {
        self.estimatedItemSize = .zero
        let size = (width / 2) - margin 
        self.itemSize = CGSize(width: size, height: size * 1.5)
        self.sectionInset = UIEdgeInsets(top: margin, left: margin / 2, bottom: 8, right: margin / 2)
        self.scrollDirection = .vertical
    }
}

