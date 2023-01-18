//
//  DIConfigurator.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import RecipeAppDomain
import RecipeAppData

public class DIConfigurator {

   static let client = RestClient(baseURL: "https://api.spoonacular.com")
    
    func injectRecipeListViewmodel() -> RecipeListViewModel {
        let repository: RecipeListRepositoryType = RecipeListRepository(client: DIConfigurator.client)
        let useCase: RecipeListUseCase = RecipeListUseCase(repository: repository)
        return RecipeListViewModel(useCase: useCase)
    }
    
    func injectRecipeDetailViewModel() -> RecipeDetailViewModel {

        let repository: RecipeDetailRepositoryType = RecipeDetailRepository(client: DIConfigurator.client)
        let useCase: RecipeDetailUseCase = RecipeDetailUseCase(repository: repository)
        return RecipeDetailViewModel(useCase: useCase)
    }
}
