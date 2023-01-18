//
//  RecipeDetailView.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import SwiftUI
import RecipeAppDomain

struct RecipeDetailView: View {
    
    @State var recipeId: String
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    init(recipeId: String, viewModel: RecipeDetailViewModel) {
        self.recipeId = recipeId
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(self.viewModel.recipeDetail?.title ?? "No tiene titulo")
                .font(.system(size: 22, weight: .bold, design: .default))
                .foregroundColor(.black)
            
            GeometryReader { geometry in
                AsyncImage(url: self.viewModel.recipeDetail?.imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 250, maxHeight: 200)
                    
                } placeholder: {
                    ProgressView()
                }
                FavoriteButtonView(isFavorite: self.viewModel.isFavorite) {
                    self.viewModel.didTapFavoriteButton()
                }
                .position(x: geometry.size.width - 20, y: geometry.size.height - 20)
            }.frame(width: 300, height: 250)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Summary")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .foregroundColor(.black)
                Text(self.viewModel.recipeDetail?.summary ?? "")
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .foregroundColor(.black)
                Text("Health score")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .foregroundColor(.black)
                Text(self.viewModel.recipeDetail?.healthScore ?? "")
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .foregroundColor(.black)
            }
            .font(.headline)
            .padding()
            Spacer()
        }.alert(isPresented: $viewModel.isError) {
            Alert(title: Text("Error"), message: Text(self.viewModel.errorText))
        }
        .onAppear(perform: {
            self.viewModel.getRecipeById(recipeId)})
    }
}
