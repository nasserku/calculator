//
//  ContentView.swift
//  NewsAPI-naser
//
//  Created by Naser on 20/03/2024.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        NavigationView {
            List(articles) { article in
                NavigationLink(destination: Text(article.content ?? "No content")) {
                    Text(article.title)
                }
            }
            .navigationTitle("Articles")
        }
        .onAppear {
            fetchArticles()
        }
    }
    
    private func fetchArticles() {
        NewsAPI.fetchArticles()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { articles in
                self.articles = articles
            })
            .store(in: &cancellables)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

