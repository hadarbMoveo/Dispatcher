//
//  ArticleDetailsPageViewController.swift
//  Dispatcher
//
//  Created by Hadar Basson on 27/08/2023.
//

import UIKit

class ArticleDetailsPageViewController: UIViewController {
    
    var viewModel: ArticleDetailsPageViewModel
    let vcView: ArticleDetailsView
    
    init(viewModel: ArticleDetailsPageViewModel) {
        self.viewModel = viewModel
        self.vcView = ArticleDetailsView(frame: .zero ,article: viewModel.article)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func loadView() {
        self.view = vcView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

