//
//  ArticleDetailsPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 27/08/2023.
//

import UIKit

class ArticleDetailsPageViewController: UIViewController {
    
    var viewModel: ArticleDetailsPageViewModel

    init(viewModel: ArticleDetailsPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let vcView = ArticleDetailsView()
    override func loadView() {
        self.view = vcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()()
    }
    
    func setupUI()() {
        setImage()
        vcView.date.text = convertDateString(viewModel.article?.publishedAt ?? "")
        vcView.title.text = (viewModel.article?.title ?? "")
        vcView.author.text = (viewModel.article?.author ?? "")
        vcView.content.text = (viewModel.article?.content ?? "")
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
    
    func setImage() {
        if(viewModel.article?.urlToImage != nil) {
            let url = URL(string: viewModel.article?.urlToImage ?? "")
            vcView.image.kf.setImage(with: url)
        }else{
            vcView.image.image = UIImage(named: "no-image")
        }
    }
}

