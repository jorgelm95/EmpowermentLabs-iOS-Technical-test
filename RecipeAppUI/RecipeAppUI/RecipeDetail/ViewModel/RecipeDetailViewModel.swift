//
//  RecipeDetailViewModel.swift
//  RecipeAppUI
//
//  Created by Jorge Menco on 1/17/23.
//

import Foundation
import Combine
import RecipeAppDomain

public protocol RecipeDetailViewModelType: ObservableObject, AnyObject {
    var recipeDetail: RecipeDetail? { get set }
    var isFavorite: Bool { get set }
    func getRecipeById(_ id: String)
    func didTapFavoriteButton()
}

public class RecipeDetailViewModel: RecipeDetailViewModelType  {
    
    @Published public var recipeDetail: RecipeDetail?
    @Published public var isFavorite: Bool = false
    @Published public var isError: Bool = false
    @Published public var errorText: String = ""
    
    private var suscribers: Set<AnyCancellable> = []
    private var useCase: BaseUseCase<RecipeDetail, String>
    
    public init(useCase: BaseUseCase<RecipeDetail, String>){
        self.useCase = useCase
    }
    
    public func getRecipeById(_ id: String) {
        self.useCase.buildUseCase(params: id).sink { completion in
            switch completion {
            case .failure(let error):
                self.handleError(error: error)
                debugPrint("error \(error)")
            case .finished:
                debugPrint("finalizado")
            }
        } receiveValue: { value in
            self.recipeDetail = value
        }.store(in: &suscribers)
    }
    
    public func didTapFavoriteButton() {
        self.isFavorite = true
        print("save as favorite")
    }
    
    private func handleError(error: Error) {
        self.isError.toggle()
        guard let errorResult = error as? DomainError else {
            return
        }
        
        switch errorResult {
        case .custom(let message):
            self.errorText = message
        break
        }
    }
}
