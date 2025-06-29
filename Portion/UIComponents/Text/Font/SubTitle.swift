//
//  SubTitle.swift
//  Portion
//
//  Created by David Amedeka on 6/14/25.
//

import Foundation
import SwiftUI

struct SubTitle: ViewModifier {
    var textColor: Color
    init(textColor: Color) {
        self.textColor = textColor
    }
    init() {
        self.textColor = .primary
    }
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.bottom, 2)
            .font(.title3)
            .fontWeight(.medium)
            .foregroundStyle(textColor)
    }
    
}

extension View {
    func subTitle() -> some View {
        modifier(SubTitle())
    }
}
