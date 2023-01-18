//
//  SplashScreenView.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import Foundation
import SwiftUI
import RecipeAppDomain
import RecipeAppData

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.0
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            RecipeListView()
        } else {
            VStack {
                VStack {
                    Image(uiImage: UIImage(named:"AppIcon")!)
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("Recipe App")
                        .font(Font.custom("Baskerville-Bold", size: 36))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.0)) {
                        self.size = 0.3
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


public class Configurator {

   static let client = RestClient(baseURL: "https://api.spoonacular.com")
    
    func injectRecipeListViewmodel() -> RecipeListViewModel {
        let repository: RecipeListRepositoryType = RecipeListRepository(client: Configurator.client)
        let useCase: RecipeListUseCase = RecipeListUseCase(repository: repository)
        return RecipeListViewModel(useCase: useCase)
    }
    
    func injectRecipeDetailViewModel() -> RecipeDetailViewModel {

        let repository: RecipeDetailRepositoryType = RecipeDetailRepository(client: Configurator.client)
        let useCase: RecipeDetailUseCase = RecipeDetailUseCase(repository: repository)
        return RecipeDetailViewModel(useCase: useCase)
    }
}
