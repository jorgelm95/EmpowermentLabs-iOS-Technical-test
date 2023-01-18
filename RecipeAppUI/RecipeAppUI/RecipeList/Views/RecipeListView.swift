//
//  RecipeListView.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import Foundation
import SwiftUI
import RecipeAppDomain
import RecipeAppData

struct RecipeListView: View {
    
    @State private var searchText: String = ""
    
    @ObservedObject private var ViewModel:  RecipeListViewModel = Configurator().injectRecipeListViewmodel()
    
    public init() {}
    
    var body: some View {
        NavigationView {
            List(self.ViewModel.recipeResul?.results ?? [], id: \.identifier) { recipe in
                NavigationLink(destination: RecipeDetailView(
                    recipeId: String(recipe.identifier ?? 0),
                    viewModel: Configurator().injectRecipeDetailViewModel())) {
                        RecipeCardView(image: getImageURL(urlString: recipe.imageURL ?? ""), title: recipe.title ?? "", identifier: String(recipe.identifier ?? 0))
                    }
            }.navigationTitle("Recipes")
        }.searchable(text: $searchText)
            .onChange(of: searchText) { value in
                Task {
                    if !value.isEmpty && value.count > 3 {
                        self.ViewModel.searchListRecipe(query: value)
                    } else {
                        self.ViewModel.resetList()
                    }
                }
            }
            .alert(isPresented: $ViewModel.isError) {
                Alert(title: Text("Error"), message: Text(self.ViewModel.errorText))
            }
    }
    
    private func getImageURL(urlString: String) -> URL? {
        return URL(string: urlString)
    }
}

