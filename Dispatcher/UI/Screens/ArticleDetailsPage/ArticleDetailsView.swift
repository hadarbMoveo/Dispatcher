//
//  ArticleDetailsView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 27/08/2023.
//

import UIKit

class ArticleDetailsView: UIView {
    
    var article: NewsArticle?
    let customColor = UIColor(named: "your-article-details-color")
    
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "sport"
        label.textColor = .black
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "metaData-img"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = article?.title
        return titleLable
    }()
    
    lazy var dateLable: UILabel = {
        let dateLable = UILabel()
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        dateLable.text = String(article?.publishedAt ?? "defult")
        dateLable.textColor = .black
        return dateLable
    }()
    
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = article?.content
        textView.backgroundColor = .white
        return textView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = article?.author
        label.textColor = .black
        return label
    }()
    
    
    init(frame: CGRect, article: NewsArticle) {
        self.article = article
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        addSubview(image)
        addSubview(dateLable)
        addSubview(titleLable)
        addSubview(authorLabel)
        addSubview(contentTextView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 0),
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 0),
            image.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 0),
            
            
            dateLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateLable.topAnchor.constraint(equalTo: image.bottomAnchor ,constant: 8),
            
            titleLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLable.topAnchor.constraint(equalTo: dateLable.bottomAnchor ,constant: 8),
            
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor ,constant: 8),
            
            contentTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentTextView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor ,constant: 8),
            contentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor ,constant: 8),

            
        ])

    }
}

