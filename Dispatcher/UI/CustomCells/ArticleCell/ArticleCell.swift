import UIKit
import Alamofire
import Kingfisher

class ArticleCell: UITableViewCell {
    weak var delegate: HomePageViewControllerDelegate?
    static let identifier = "ArticleCell"
    @IBOutlet weak var viewcard: UIView!
    @IBOutlet weak var tagCard: UILabel!
    @IBOutlet weak var summaryCard: UITextView!
    @IBOutlet weak var authorCard: UILabel!
    @IBOutlet weak var dateCard: UILabel!
    @IBOutlet weak var imageUrlCard: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var iconFav: UIButton!
    var isFavorite: Bool = false
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewcard.layer.cornerRadius = 30
        viewcard.layer.masksToBounds = true
        iconFav.layer.cornerRadius = 17
        iconFav.layer.masksToBounds = true
        setIconFavorite()
    }
    
    func initCell(article: Article?) {
        guard let article else { return }
        tagCard.text = article.tag
        summaryCard.text = article.summary
        authorCard.text = article.author
        dateCard.text = article.date
        titleCard.text = article.title
    }
    
    func setIconFavorite(){
        if (isFavorite){
            iconFav.setImage(UIImage(named:"full-star-icon"), for: .normal)
        }
        else{
            iconFav.setImage(UIImage(named:"blank-star-icon"), for: .normal)
        }
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        delegate?.setFevorite(index: index)
    }
    
    func initCell(with article: NewsArticle?) {
        guard let article else { return }
        tagCard.text = "Sport"
        summaryCard.text = article.description
        authorCard.text = article.author
        dateCard.text = convertDateString(article.publishedAt ?? "")
        titleCard.text = article.title
        isFavorite = article.isFavorite
        setIconFavorite()
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
    
    func setImage(urlImage:String) {
        if urlImage == "" {
            imageUrlCard.image = UIImage(named: "no-image")
        }
        else {
            let url = URL(string: urlImage)
            imageUrlCard.kf.setImage(with: url)
        }
    }
}
