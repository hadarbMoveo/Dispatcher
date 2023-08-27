//
//  SearchCell.swift
//  Dispatcher
//
//  Created by Hadar Basson on 23/08/2023.
//

import UIKit
protocol SearchPageViewControllerDelegate: AnyObject {
    func remove(at: Int)
}

class SearchCell: UITableViewCell {
    weak var delegate: SearchPageViewControllerDelegate?
    static let identifier = "SearchCell"
    var index: Int = 0
    
    @IBOutlet weak var searchLable: UILabel!
    @IBOutlet weak var removeSearchButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        removeSearchButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
           
    @objc func removeButtonTapped() {
        delegate?.remove(at: index)
    }
}
