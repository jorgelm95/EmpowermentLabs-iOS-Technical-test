//
//  CardViewModifier.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import Foundation
import SwiftUI

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}


