//
//  BaseViewModel.swift
//  UnsplashMock
//
//  Created by Elbek Khasanov on 11/01/22.
//

import Foundation
protocol BaseViewModel {
    var isLoading: Bool { get set }
    var error: String? { get set }
}
