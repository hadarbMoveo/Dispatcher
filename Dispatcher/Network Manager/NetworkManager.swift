//
//  NetworkManager.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//

import Foundation
import Alamofire

class NetworkManager {
    func request(url:String,method:String,completion:@escaping(Any)->Void) {
        AF.request(url, method:HTTPMethod(rawValue: method))
            .response { resp in
                switch resp.result {
                case .success(let data):
                    completion(data ?? Data())
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }
    }
}








