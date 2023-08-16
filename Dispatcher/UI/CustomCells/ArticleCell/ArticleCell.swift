import UIKit

class ArticleCell: UITableViewCell {
    
    static let identifier = "ArticleCell"
    @IBOutlet weak var Viewcard: UIView!
    @IBOutlet weak var tagCard: UILabel!
    @IBOutlet weak var summaryCard: UITextView!
    @IBOutlet weak var authorCard: UILabel!
    @IBOutlet weak var dateCard: UILabel!
    @IBOutlet weak var imageUrlCard: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Viewcard.layer.cornerRadius = 30
        Viewcard.layer.masksToBounds = true
    }
    
    func initCell(article: Article?) {
        guard let article else { return }
        tagCard.text = article.tag
        summaryCard.text = article.summary
        authorCard.text = article.author
        dateCard.text = article.date
        titleCard.text = article.title
    }
}
