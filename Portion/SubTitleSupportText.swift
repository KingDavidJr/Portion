//
//  SubTitleSupportText.swift
//  Portion
//
//  Created by David Amedeka on 6/14/25.
//

import Foundation
import SwiftUI

struct SubTitleSupportText : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .font(.callout)
            .foregroundStyle(.gray)
            .opacity(0.8)
    }
}

extension View {
    func subTitleSupportText() -> some View {
        modifier(SubTitleSupportText())
    }
}
