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
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            Text(text)
                .foregroundStyle(textColor)
        }
        .padding()
        .containerRelativeFrame(.vertical) { size, axis in
            size * 0.125
        }
    }
}

#Preview {
    UniversalButton()
}
