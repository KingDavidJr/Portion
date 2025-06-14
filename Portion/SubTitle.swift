//
//  SubTitle.swift
//  Portion
//
//  Created by David Amedeka on 6/14/25.
//

import Foundation
import SwiftUI

struct SubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.medium)
    }
    
}

extension View {
    func subTitle() -> some View {
        modifier(SubTitle())
    }
}
