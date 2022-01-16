//
//  Click+Extension.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 13/01/22.
//


import UIKit
extension UIView {
    func pulse(completion: @escaping() -> Void) {
        self.self.transform = .identity
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.transform = .init(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.self.transform = .identity
            } completion: { _ in
                completion()
            }

        }

    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 1
        animation.values = [-5.0, 5.0, -3.0, 3.0, -2.0, 2.0, -1.0, 1.0, 0]
        self.layer.add(animation, forKey: "shake")
    }
    
    func displayAnimation() {
        self.alpha = 0
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.self.alpha = 1
        }
    }
}
