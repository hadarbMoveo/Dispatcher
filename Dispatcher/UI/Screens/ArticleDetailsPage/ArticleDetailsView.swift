//
//  ArticleDetailsView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 27/08/2023.
//

import UIKit
import Kingfisher

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
        let url = URL(string: article?.urlToImage ?? "")
        image.kf.setImage(with: url)
        return image
    }()
    
    lazy var dateLable: UILabel = {
        let dateLable = UILabel()
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        dateLable.text=convertDateString(article?.publishedAt ?? "")
//        dateLable.text = String(article?.publishedAt ?? "defult")
        let customColor = UIColor(named: "date-color")
        dateLable.textColor = customColor
//        dateLable.numberOfLines = 3
        dateLable.font = UIFont(name: "Roboto-Regular", size: 14)
        return dateLable
    }()
    
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = article?.title
        titleLable.font = UIFont.boldSystemFont(ofSize: 18)
        titleLable.numberOfLines = 3
        return titleLable
    }()
    

    lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = article?.author
        let customColor = UIColor(named: "date-color")
        authorLabel.textColor = customColor
       
        return authorLabel
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = article?.content
        let customColor = UIColor(named: "content-color")
        textView.textColor = customColor
        textView.isScrollEnabled = true
        textView.textAlignment = .left
        return textView
    }()
    

    
    
    init(frame: CGRect, article: NewsArticle?) {
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
            image.heightAnchor.constraint(equalToConstant: 183),
            
            
            dateLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateLable.topAnchor.constraint(equalTo: image.bottomAnchor ,constant: 12),
            
            titleLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLable.topAnchor.constraint(equalTo: dateLable.bottomAnchor ,constant: 12),
            
            authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor ,constant: 12),
            
            contentTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentTextView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor ,constant: 12),
            contentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor ,constant: 8),
        ])

    }
    
    func convertDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yy"
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
    
}

