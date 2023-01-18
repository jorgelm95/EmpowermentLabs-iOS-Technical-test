//
//  FavoriteButtonView.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import SwiftUI

struct FavoriteButtonView: View {
    
    var isFavorite: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
             Image(systemName: "heart.fill")
                 .resizable()
                 .frame(width: 30, height: 30)
                 .foregroundColor(isFavorite ? .red : .gray)
         }
    }
}

struct FavoriteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButtonView(isFavorite: false, action: { })
    }
}
