//
//  UniversalButton.swift
//  Portion
//
//  Created by David Amedeka on 6/14/25.
//

import SwiftUI

struct UniversalButton: View {
    var color: Color
    var text: String
    
    init(color: Color, text: String) {
        self.color = color
        self.text = text
    }
    
    init() {
        self.color = .blue
        self.text = ""
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UniversalButton()
}
