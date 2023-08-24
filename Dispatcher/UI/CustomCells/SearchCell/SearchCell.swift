//
//  SearchCell.swift
//  Dispatcher
//
//  Created by Hadar Basson on 23/08/2023.
//

import UIKit
protocol SearchDelegate: AnyObject {
    func remove(at:Int)
}

class SearchCell: UITableViewCell {
    @IBOutlet weak var searchLable: UILabel!
    @IBOutlet weak var removeSearchButton: UIButton!
    weak var delegate: SearchDelegate?
    
    static let identifier = "SearchCell"
    var index: Int = 0
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
