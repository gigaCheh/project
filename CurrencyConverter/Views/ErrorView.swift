//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 30.03.2024.
//

import UIKit

final class ErrorView: UIView {
    
    private lazy var errorImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "CourseDashboardErrorView:error-imageView"
        return view
    }()// UIImage
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "GeneralErrorView:error:label"
        label.numberOfLines = 0
        label.text = "Error Occured"
        label.textColor = .black
        return label
    }()// label
    
    private lazy var retryButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.accessibilityIdentifier = "GeneralErrorView:error-action-button"
        button.backgroundColor = .white
        
        return button
    }()// button
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    func update(text: String, image: UIImage) {
        self.errorImageView.image = image
        self.errorLabel.text = text
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ErrorView {
    func commonInit() {
        setupSubviews()
        //setupConstraints()
    }

    func setupSubviews() {
        backgroundColor = .white
        
        addSubview(errorImageView)
        addSubview(errorLabel)
        addSubview(retryButton)
    }

    func setupConstraints() {
        
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        [errorImageView, errorLabel, retryButton].forEach {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                $0.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
            ])
        }// TODO: layout + размеры
        
    }
 
}
