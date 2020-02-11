//
//  WebView.swift
//  n3wz
//
//  Created by Lucas Gerisztein on 11.02.20.
//  Copyright © 2020 Lucas Gerisztein. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
  
  let urlString: String?
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    if let urlString = urlString {
      if let url = URL(string: urlString) {
        let request = URLRequest(url: url)
        uiView.load(request)
      }
    }
  }
}
