//
//  ContentView.swift
//  n3wz
//
//  Created by Lucas Gerisztein on 11.02.20.
//  Copyright © 2020 Lucas Gerisztein. All rights reserved.
//
import SwiftUI

struct ContentView: View {
  @ObservedObject var networkManager = NetworkManager()
  
  var body: some View {
    NavigationView {
      List(networkManager.articles) { article in
        NavigationLink(destination: DetailView(url: article.url)) {
          Item(description: article.description, source: article.source.name, title: article.title, urlToImage: article.urlToImage)
        }
      }
      .navigationBarTitle("n3wz")
    }
    .onAppear {
      self.networkManager.fetchData()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct Item: View {
  var description: String?
  var source: String
  var title: String
  var urlToImage: String
  
  init(description: String?, source: String, title: String, urlToImage: String) {
    
    self.imageLoader = Loader(urlToImage)
    self.description = description ?? ""
    self.source = source
    self.title = title
    self.urlToImage = urlToImage
  }
  
  @ObservedObject private var imageLoader: Loader
  var image: UIImage? {
    imageLoader.data.flatMap(UIImage.init)
  }
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Image(uiImage: image ?? placeholder)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(maxHeight: 200)
        .clipShape(RoundedRectangle(cornerRadius: CGFloat(20))
      )
      Text(title)
        .bold()
        .font(.system(size: 20))
      Text(source)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.vertical)
      Text(description ?? "")
        .font(.system(size: 16))
        .padding(.bottom)
    }
  }
}

final class Loader: ObservableObject {
  
  var task: URLSessionDataTask!
  @Published var data: Data? = nil
  
  init(_ url: String) {
    var urlString = url
    urlString = urlString.replacingOccurrences(of: "http://", with: "https://")
    let urlSafe = URL(string: urlString)
    
    task = URLSession.shared.dataTask(with: urlSafe!, completionHandler: { data, _, _ in
      DispatchQueue.main.async {
        self.data = data
      }
    })
    task.resume()
  }
  deinit {
    task.cancel()
  }
}

let placeholder = UIImage(named: "placeholder.png")!
