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
        //setupConstraints()
    }

    func setupSubviews() {
        backgroundColor = .white
        addSubview(activityIndicatorView)
    }

    func setupConstraints() {
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            activityIndicatorView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            activityIndicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
                                    ])
        activityIndicatorView.startAnimating()
        // TODO: activityIndicatorView - 40x40 + по центру
    }
 
}

