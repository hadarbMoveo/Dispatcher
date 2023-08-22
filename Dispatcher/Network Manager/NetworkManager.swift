//
//  NetworkManager.swift
//  Dispatcher
//
//  Created by Hadar Basson on 20/08/2023.
//

import Foundation
import Alamofire

class NetworkManager {
    func request<T: Decodable>(url: String, method:String, completion: @escaping (T) -> Void) {
          AF.request(url,method:HTTPMethod(rawValue: method))
              .response { resp in
                  switch resp.result {
                  case .success(let data):
                      do {
                          let jsonData: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                          completion(jsonData)
                      } catch {
                          print("Error decoding JSON: \(error.localizedDescription)")
                      }
                  case .failure(let error):
                      print("Error fetching data: \(error.localizedDescription)")
                  }
              }
      }
}
        
        
//        let t = AF.request(url, method: .get).serializingDecodable(T.self)
//        do {
//            let x = await t.value
//            return x
//        } catch {
//
//        }
  
    









