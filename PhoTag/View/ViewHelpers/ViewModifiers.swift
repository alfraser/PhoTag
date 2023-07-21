//
//  ViewModifiers.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import SwiftUI


// MARK: LabelFormat
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

// MARK: WithSystemImageButton
struct SystemImageButton: ViewModifier {
    let systemImage: String
    let action: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        action()
                    } label: {
                        Image(systemName: systemImage)
                            .padding(8)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

extension View {
    func withSystemImageButton(systemImage: String, action: @escaping () -> Void ) -> some View {
        modifier(SystemImageButton(systemImage: systemImage, action: action))
    }
}
