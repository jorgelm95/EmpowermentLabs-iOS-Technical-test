//
//  RecipeListViewModel.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import Foundation
import Combine
import SwiftUI
import RecipeAppDomain

public final class  RecipeListState: ObservableObject {
    @Published var searchText: String = ""
}

public protocol RecipeListVieModelType: ObservableObject {
    
    func searchListRecipe(query: String)
}


public class RecipeListViewModel: RecipeListVieModelType {
  
    @Published public var recipeResul: RecipeResult?
    @Published public var isError: Bool = false
    @Published public var errorText: String = ""
    
    private var suscribers: Set<AnyCancellable> = []
    private var useCase: BaseUseCase<RecipeResult, SearchRecipeParams>
    
    public init(useCase: BaseUseCase<RecipeResult, SearchRecipeParams>){
        self.useCase = useCase
        self.recipeResul = RecipeResult(results: [], offset: 0, number: 0, totalResults: 0)
    }
    
    public func searchListRecipe(query: String) {
        let params = SearchRecipeParams(query: query, paging: Pagination(offset: 10, number: 10, total: 50))
        self.useCase.buildUseCase(params: params).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .failure(let error):
                self.isError.toggle()
                self.errorText = error.localizedDescription
                debugPrint("error \(error.localizedDescription)")
            case .finished:
                debugPrint("finalizado")
            }
        } receiveValue: { value in
            self.recipeResul = value
        }.store(in: &suscribers)
    }
    
    public func resetList() {
        self.recipeResul = nil
    }
}
