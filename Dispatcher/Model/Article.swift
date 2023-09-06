import Foundation

protocol Card { var isFavorite: Bool { get set }}

struct Article: Card {
    var imgUrl: String
    var title: String
    var summary: String
    var author: String
    var date: String
    var tag: String
    var content: String
    var isFavorite: Bool
}

struct NewsResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable,Card {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var isFavorite: Bool
    
    enum CodingKeys: CodingKey {
        case author
        case title
        case description
        case urlToImage
        case publishedAt
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.isFavorite = false
    }
    
    init(author:String,title:String,description:String,urlToImage:String,publishedAt:String,content:String,isFavorite:Bool) {
        self.author = author
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.isFavorite = isFavorite
    }
    
}

