//
//  NetworkManager.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//

import Foundation
import Alamofire

class NetworkManager {
    let apiKey = "ef5133dd364c41719494a74ce614d679"
    let articlesNumber = 7
    func fetchNews(completion:@escaping([NewsArticle])->Void) {
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)&pageSize=\(articlesNumber)"
        AF.request(url, method: .get)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(NewsResponse.self, from: data!)
                        let articles = jsonData.articles
                        print(articles)
                        completion(articles)
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }
    }
}








