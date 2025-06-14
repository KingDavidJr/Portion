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
    var textColor: Color
    
    init(color: Color, text: String, textColor: Color) {
        self.color = color
        self.text = text
        self.textColor = textColor
    }
    
    init() {
        self.color = .blue
        self.text = ""
        self.textColor = .white
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UniversalButton()
}
