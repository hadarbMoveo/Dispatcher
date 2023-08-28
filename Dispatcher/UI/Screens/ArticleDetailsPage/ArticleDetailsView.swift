//
//  ArticleDetailsView.swift
//  Dispatcher
//
//  Created by Hadar Basson on 27/08/2023.
//

import UIKit
import Kingfisher

class ArticleDetailsView: UIView {
    
    let article: NewsArticle?
    let customColor = UIColor(named: "your-article-details-color")
    
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "metaData-img"))
        image.translatesAutoresizingMaskIntoConstraints = false
        if(article?.urlToImage != nil) {
            let url = URL(string: article?.urlToImage ?? "")
            image.kf.setImage(with: url)
            return image
        }
        image.image = UIImage(named: "no-image")
        return image
    }()
    
    lazy var date: UILabel = {
        let dateLable = UILabel()
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        dateLable.text=convertDateString(article?.publishedAt ?? "")
        let customColor = UIColor(named: "date-color")
        dateLable.textColor = customColor
        dateLable.font = UIFont(name: "Roboto-Regular", size: 14)
        return dateLable
    }()
    
    
    lazy var title: UILabel = {
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = article?.title
        titleLable.font = UIFont.boldSystemFont(ofSize: 18)
        titleLable.numberOfLines = 4
        return titleLable
    }()
    

    lazy var author: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = article?.author
        let customColor = UIColor(named: "date-color")
        authorLabel.textColor = customColor
        authorLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        authorLabel.numberOfLines = 2
       
        return authorLabel
    }()
    
    lazy var content: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = article?.content
        let customColor = UIColor(named: "content-color")
        textView.textColor = customColor
        textView.font = UIFont.systemFont(ofSize: 16)
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
        addSubview(date)
        addSubview(title)
        addSubview(author)
        addSubview(content)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 0),
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 0),
            image.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 0),
            image.heightAnchor.constraint(equalToConstant: 183),
            
            
            date.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            date.topAnchor.constraint(equalTo: image.bottomAnchor ,constant: 12),
            
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: date.bottomAnchor ,constant: 12),
            
            author.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            author.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            author.topAnchor.constraint(equalTo: title.bottomAnchor ,constant: 12),
            
            content.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            content.topAnchor.constraint(equalTo: author.bottomAnchor ,constant: 12),
            content.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor ,constant: 8),
        
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

