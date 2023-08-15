import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var tagCard: UILabel!
    @IBOutlet weak var summaryCard: UITextView!
    @IBOutlet weak var authorCard: UILabel!
    @IBOutlet weak var dateCard: UILabel!
    @IBOutlet weak var imageUrlCard: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
