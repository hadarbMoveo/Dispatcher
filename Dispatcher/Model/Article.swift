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


