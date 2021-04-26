//
//  WebView.swift
//  NewsReader
//
//  Created by Sergey Antoniuk on 12/3/20.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WebView.UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let saveString = urlString{
            if let url = URL(string: saveString){
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
