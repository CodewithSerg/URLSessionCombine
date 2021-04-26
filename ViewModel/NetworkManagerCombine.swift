//
//  NetworkManagerCombine.swift
//  NewsReader
//
//  Created by Sergey Antoniuk on 4/26/21.
//
import Foundation
import Combine

class NetworkManagerCombine: ObservableObject {
    
    @Published var posts = [Post]()
    var cancellables = Set<AnyCancellable>()
    
    init () {
        getPosts()
        
    }
    
    func getPosts() {
        guard let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Results.self, decoder: JSONDecoder())
            .sink { (complition) in
                print("Complition: \(complition)")
            } receiveValue: { [weak self] (returnedValue) in
                self?.posts = returnedValue.hits
            }
            .store(in: &cancellables)
            

    }
}



