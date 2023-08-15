import Foundation

protocol Card{
}

struct Article: Card {
    var imgUrl: String
    var title: String
    var summary: String
    var author: String
    var date: String
    var tag: String
}



class DataSource {
    var articels:[Card]=[Article(imgUrl:"lala",title:"mama",summary:"lala",author:"lala",date:"lala",tag:"lala"),
                         Article(imgUrl:"lala",title:"lala",summary:"lala",author:"lala",date:"lala",tag:"lala"),Article(imgUrl:"lala",title:"lala",summary:"lala",author:"lala",date:"lala",tag:"lala"),Article(imgUrl:"lala",title:"lala",summary:"lala",author:"lala",date:"lala",tag:"lala")]
    
    static let singletonDataSource = DataSource()
    
    static func getData () -> [Card]{
        return singletonDataSource.articels
    }
    
}




