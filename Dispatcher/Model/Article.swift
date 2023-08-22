import Foundation

protocol Card {}

struct Article: Card {
    var imgUrl: String
    var title: String
    var summary: String
    var author: String
    var date: String
    var tag: String
}

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable,Card {
    let author: String?
    let title: String
    let description: String
    let urlToImage: String?
    let publishedAt: String
}


