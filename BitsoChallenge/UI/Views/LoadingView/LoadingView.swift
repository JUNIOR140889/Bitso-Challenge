//
//  LoadingView.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit

protocol LoadingProtocol: class {
    var loadingView: LoadingView { get }
    func startLoading()
    func stopLoading()
}

extension LoadingProtocol where Self: UIViewController {
    func startLoading() {
        loadingView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height)
        view.addSubview(loadingView)
        loadingView.insetsToSuperview()
        loadingView.loader.startAnimating()
    }

    func stopLoading() {
        loadingView.loader.stopAnimating()
        loadingView.removeFromSuperview()
    }

}

final class LoadingView: UIView {
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.style = .medium
        loader.color = .white
        return loader
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        setupActivityControl()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Error - Container Loader")
    }

    fileprivate func setupActivityControl() {
        addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

extension UIView {
    func insetsToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superView = self.superview {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superView.topAnchor),
                leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                bottomAnchor.constraint(equalTo: superView.bottomAnchor)
            ])
        }
    }
}
