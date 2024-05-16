//
//  LoadingView.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 30.03.2024.
//

import UIKit

final class LoadingView: UIView {
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoadingView {
    
    func commonInit() {
        setupSubviews()
        setupConstraints()
        
        activityIndicatorView.startAnimating()
    }

    func setupSubviews() {
        backgroundColor = .white
        addSubview(activityIndicatorView)
    }

    func setupConstraints() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 40.0),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 40.0)
        ])

    }
}
