//
//  TextFieldUI.swift
//  Portion
//
//  Created by David Amedeka on 6/29/25.
//

import SwiftUI

struct TextFieldUI: View {
    @State var text: Binding<String>
    var prompt: Text
    
    init(text: Binding<String>, prompt: String) {
        self.text = text
        self.prompt = Text(prompt)
    }
    
    var body: some View {
        TextField(text: text, prompt: prompt) {
            
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        }
        .padding()
    }
}

#Preview {
    TextFieldUI(text: .constant(""), prompt: "Test Prompt")
}
