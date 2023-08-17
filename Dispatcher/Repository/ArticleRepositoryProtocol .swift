import Foundation

protocol ArticleRepositoryProtocol  {
 func getArticles()->[Card]
}

class MockArticleRepository: ArticleRepositoryProtocol  {
    func getArticles() -> [Card] {
        var articels: [Card] = [
            Article(imgUrl:"",
                    title:"UBS to pay $1.4 bn to settle US fraud charges on subprime loans",
                    summary:"UBS will pay $1.4 billion to settle US charges that it defrauded investors in the sale of mortgage-backed securities, resolving the last big case stemming from the 2008 financial crisis, the Justice Department announced Monday.",
                    author:"Max Labovich",
                    date:"16/07/23",
                    tag:"Finance"),
            Article(imgUrl:"",
                    title:"Have your eye on a Tesla? It just got $10,000 cheaper to buy a Model S or Model X.",
                    summary:"Tesla is now selling versions of the Model S and Model X, which cost $10,000 less but offer less range and slower 0-60 speeds.",
                    author:"Kylie Kirschner",
                    date:"16/07/23",
                    tag:"Cars"),
            Article(imgUrl:"",
                    title:"rom Dance Floor to Dashboard: How Techno Is Helping Change The Sound Of Cars For the Better",
                    summary:"Electric vehicles are giving automobile companies a chance to reinvent how cars sound - and many are turning to producers to help them create radically new sound palettes",
                    author:"Adam Douglas",
                    date:"16/07/23",
                    tag:"Cars"),
            Article(imgUrl:"",
                    title:"Asian stocks slip as China data continues to disappoint - Reuters",
                    summary:"Asian stocks stumbled on Wednesday, as more disappointing Chinese economic data and the absence of meaningful stimulus from Beijing continued to weigh on investor sentiment",
                    author:"Kane Wu",
                    date:"16/07/23",
                    tag:"Business")
        ]
        return articels
    }
}
