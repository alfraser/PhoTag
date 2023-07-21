//
//  ViewModifiers.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import SwiftUI

struct LabelFormat: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(6.0)
            .background(.white.opacity(0.8))
            .clipShape(Capsule())
            .padding(6.0)
        
    }
}

extension View {
    func asLabel() -> some View {
        modifier(LabelFormat())
    }
}
