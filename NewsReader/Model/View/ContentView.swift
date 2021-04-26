//
//  ContentView.swift
//  NewsReader
//
//  Created by Sergey Antoniuk on 12/2/20.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var networkManager = NetworkManagerCombine()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){post in
                NavigationLink(
                    destination: DetailView(url: post.url)) {
                
                        HStack{
                        Text(String(post.points))
                        Text(post.title)
                            .foregroundColor(.blue)
                        }
                    }
                
                        
        } .navigationBarTitle("\(networkManager.posts.count) TOP News")
        }
//        .onAppear(perform: {
//            self.networkManager.getPosts()
//        })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
