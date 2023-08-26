//
//  NetworkManager.swift
//  Dispatcher
//
//  Created by Hadar Basson on 22/08/2023.
//
import Foundation
import Alamofire

class NetworkManager {
    static let apiKey = "1a679827a9184c5e85b06241c6b49955"
    //ef5133dd364c41719494a74ce614d679
    let baseUrl = "https://newsapi.org/v2"
    func request<T: Decodable>(url: String, method:String, completion: @escaping (T) -> Void) {
        let finalUrl = String("\(baseUrl)\(url)")
        AF.request(finalUrl,method:HTTPMethod(rawValue: method))
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                        completion(jsonData)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
    }
    
    
    
    
    func request<T: Decodable>(url: String, method: String, type: T.Type) async throws -> T {
        let finalUrl = "\(baseUrl)\(url)"
        let response = AF.request(finalUrl, method: HTTPMethod(rawValue: method))
            .serializingDecodable(T.self)
        do {
            let jsonData: T = try await response.value
            return jsonData
        } catch {
            throw error
        }
    }
}



