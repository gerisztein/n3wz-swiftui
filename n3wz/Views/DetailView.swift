//
//  DetailView.swift
//  n3wz
//
//  Created by Lucas Gerisztein on 11.02.20.
//  Copyright © 2020 Lucas Gerisztein. All rights reserved.
//

import SwiftUI

struct DetailView: View {
  let url: String
  
  var body: some View {
    WebView(urlString: url)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(url: "https://www.apple.com")
  }
}
