import Foundation

protocol Item{
}

struct Article: Item {
    var imgUrl: String
    var title: String
    var summary: String
    var author: String
    var date: String
    var tag: String
}



class DataSource {
    var articels:[Item]=[Article(imgUrl:"lala",title:"mama",summary:"lala",author:"lala",date:"lala",tag:"lala"),
                         Article(imgUrl:"lala",title:"lala",summary:"lala",author:"lala",date:"lala",tag:"lala"),Article(imgUrl:"lala",title:"lala",summary:"lala",author:"lala",date:"lala",tag:"lala"),Article(imgUrl:"lala",title:"lala",summary:"lala",author:"lala",date:"lala",tag:"lala")]
    
    static let singletonDataSource = DataSource()
    
    static func getData () -> [Item]{
        return singletonDataSource.articels
    }
    
}




