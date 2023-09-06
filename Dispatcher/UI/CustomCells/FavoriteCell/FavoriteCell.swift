//
//  FavoriteCell.swift
//  Dispatcher
//
//  Created by Hadar Basson on 04/09/2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"

    @IBOutlet weak var imageFavArticle: UIImageView!
    @IBOutlet weak var titleFavArticle: UILabel!
    @IBOutlet weak var iconFav: UIButton!
    var isFavorite: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconFav.layer.cornerRadius = 15
        iconFav.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func favButtonTapped(_ sender: UIButton) {
        print("remove from fav")
        isFavorite.toggle()
        setIconFavorite()
    }
    
    func setIconFavorite(){
        if (isFavorite){
            iconFav.setImage(UIImage(named:"full-star-icon"), for: .normal)
        }
        else{
            iconFav.setImage(UIImage(named:"blank-star-icon"), for: .normal)
        }
    }
    
    func initCell(with article: NewsArticle?) {
        guard let article else { return }
        titleFavArticle.text = article.title
        isFavorite = article.isFavorite
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
    
    func setImage(urlImage:String){
        if urlImage == "" {
            imageFavArticle.image = UIImage(named: "no-image")
        }
        else{
            let url = URL(string: urlImage)
            imageFavArticle.kf.setImage(with: url)
        }
    }
    
}
