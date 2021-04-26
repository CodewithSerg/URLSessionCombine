//
//  NetworkManagerEscaping.swift
//  NewsReader
//
//  Created by Sergey Antoniuk on 12/2/20.
//

import Foundation

//ViemModel
class NetworkManagerEscaping : ObservableObject {
    
    @Published var posts = [Post]()
    
    //    func fetchData() {
    //        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
    //            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
    //                if error == nil {
    //                    if let safeData = data {
    //                        do {
    //                        let results = try JSONDecoder().decode(Results.self, from: safeData)
    //                            DispatchQueue.main.async {
    //                                self.posts = results.hits
    //                            }
    //
    //                        } catch {
    //                            print(error)
    //                        }
    //                    }
    //
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    
    func getPosts(){
        
        guard let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") else {return}
        
        downloadData(from: url) { (returnedData) in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode(Results.self, from: data) else {
                    return
                }
                DispatchQueue.main.async {
                    [weak self] in
                    self?.posts = newPosts.hits
                }
            }
            else {
                print("No data returned")
            }
        }
        
        
        
    }
    func downloadData(from url: URL, complition: @escaping (_ data:Data?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let  data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error response")
                complition(nil)
                return
            }
            complition(data)
        }.resume()
    }
}

