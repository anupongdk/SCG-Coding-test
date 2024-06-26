//
//  DetailPageViewController.swift
//  Anupong
//
//  Created by gone on 26/6/2567 BE.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    var article: Article?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textColor = AppTheme.mainLabelTitleColor
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = AppTheme.mainDescriptionColor
        return label
    }()
    
    private let publishLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppTheme.dateTitleColor
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = AppTheme.mainLabelTitleColor
        
        setupViews()
        setupData()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(publishLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        publishLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            publishLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            publishLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            publishLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupData() {
        guard let article = article else { return }
        imageView.sd_setImage(with: URL(string: article.urlToImage ?? ""))
        titleLabel.text = article.title
        descriptionLabel.text = article.content
        publishLabel.text = "Updated : \(article.publishedAt.convertToAppDateFormat())"
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
