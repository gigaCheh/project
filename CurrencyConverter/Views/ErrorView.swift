//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 30.03.2024.
//

import UIKit

final class ErrorView: UIView {
    
    private lazy var errorImageView: UIImageView = {
        
        guard let image = UIImage(named: "dashboard_error_image") else { return UIImageView() }
        let imageView = UIImageView(image: image)
        imageView.accessibilityIdentifier = "CourseDashboardErrorView:error-imageView"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()// UIImage
    
    private lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.accessibilityIdentifier = "GeneralErrorView:error:label"
        label.numberOfLines = 0
        label.text = "Error Occured"
        label.textColor = .black
        
        return label
    }()// label
    
    private lazy var errorActionButton: UIButton = {
        
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
        setupConstraints()
    }

    func setupSubviews() {
        backgroundColor = .white
    }

    func setupConstraints() {
        
    }
}
