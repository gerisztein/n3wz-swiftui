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
          Item(description: article.description, source: article.sourceName, title: article.title)
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
  let description: String?
  let source: String
  let title: String
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Image("nfl")
      .resizable()
        .aspectRatio(contentMode: .fit)
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
