import UIKit
import Alamofire
import Kingfisher

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    @IBOutlet weak var viewcard: UIView!
    @IBOutlet weak var tagCard: UILabel!
    @IBOutlet weak var summaryCard: UITextView!
    @IBOutlet weak var authorCard: UILabel!
    @IBOutlet weak var dateCard: UILabel!
    @IBOutlet weak var imageUrlCard: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewcard.layer.cornerRadius = 30
        viewcard.layer.masksToBounds = true
    }
    
    func initCell(article: Article?) {
        guard let article else { return }
        tagCard.text = article.tag
        summaryCard.text = article.summary
        authorCard.text = article.author
        dateCard.text = article.date
        titleCard.text = article.title
    }
    
    func initCell(with article: NewsArticle?) {
        guard let article else { return }
        tagCard.text = "Sport"
        summaryCard.text = article.description
        authorCard.text = article.author
        dateCard.text = convertDateString(article.publishedAt ?? "")
        titleCard.text = article.title
        
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
        if urlImage == ""{
            imageUrlCard.image = UIImage(named: "no-image")
            imageUrlCard
        }
        else{
            let url = URL(string: urlImage)
            imageUrlCard.kf.setImage(with: url)
        }
    }
    
}
