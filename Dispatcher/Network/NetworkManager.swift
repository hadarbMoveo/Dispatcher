//
//  NetworkManager.swift
//  Dispatcher
//
//  Created by Hadar Basson on 22/08/2023.
//
import Foundation
import Alamofire

class NetworkManager {
    
    static let apiKey = "ef5133dd364c41719494a74ce614d679"
    
    let baseUrl = "http://localhost:3000/api/v1"
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
    
    
    
    
    func request<T: Decodable>(url: String, method: String, type: T.Type, params: [String: Any] = [:]) async throws -> T {
        let finalUrl = "\(baseUrl)\(url)"
        print(finalUrl)
        var requestParams : [String: Any] = [:]
        if(method == "post"){
             requestParams = params.isEmpty ? [:] : ["article": params]
            let response = AF.request(finalUrl, method: HTTPMethod(rawValue: method), parameters: requestParams)
                .serializingDecodable(T.self)
            do {
                let jsonData: T = try await response.value
                print(jsonData)
                return jsonData
            } catch {
                throw error
            }
        }
        
        else{
            print("hi from delete")
            let response = AF.request(finalUrl, method: HTTPMethod(rawValue: method), parameters: params)
                .serializingDecodable(T.self)
            do {
                let jsonData: T = try await response.value
                print(jsonData)
                return jsonData
            } catch {
                throw error
            }
        }

    }
}



