//
//  NetworkManager.swift
//  n3wz
//
//  Created by Lucas Gerisztein on 11.02.20.
//  Copyright © 2020 Lucas Gerisztein. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
  
  @Published var articles = [Article]()

  func fetchData() {
    let apiKey = ""
    if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: url) { (data, response, error) in
        if error == nil {
          let decoder = JSONDecoder()
          if let data = data {
            do {
              let results = try decoder.decode(Results.self, from: data)
              
              DispatchQueue.main.async {
                self.articles = results.articles
                print(results)
              }
            } catch {
              print(error)
            }
          }
        }
      }
      task.resume()
    }
  }
}
