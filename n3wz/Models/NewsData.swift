//
//  NewsData.swift
//  n3wz
//
//  Created by Lucas Gerisztein on 11.02.20.
//  Copyright © 2020 Lucas Gerisztein. All rights reserved.
//

import Foundation

struct Results: Decodable {
  let articles: [Article]
}

struct Article: Decodable, Identifiable {
  var id: String {
    return url
  }
  
  var sourceName: String {
    return source.name
  }
  
  let author: String?
  let content: String?
  let description: String?
  let source: Source
  let title: String
  let url: String
  let urlToImage: String
}

struct Source: Decodable {
  let name: String
}
