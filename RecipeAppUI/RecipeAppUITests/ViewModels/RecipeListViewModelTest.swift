//
//  RecipeListViewModelTest.swift
//  RecipeAppUITests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import XCTest

@testable import RecipeAppDomain
@testable import RecipeAppUI

final class RecipeListViewModelTest: XCTestCase {
    private var sut: RecipeListViewModel!
    private var useCaseStub: RecipeListUseCaseStub!

    override func setUp() {
        super.setUp()

        self.useCaseStub = RecipeListUseCaseStub()
        self.sut = RecipeListViewModel(useCase: useCaseStub)
    }

    override func tearDown() {
        self.sut = nil
        self.useCaseStub = nil

        super.tearDown()
    }
    
    func testSearchListRecipe_WhenSearchTextContainText_ThenSearchProductAndShowListRecipes() {
        //Give
        
        //Then
        sut.searchListRecipe(query: "pasta")
        
        //When
        XCTAssertNotNil(sut.recipeResul)
    }
    
    func testSearchListRecipe_WhenSearchTextContainText_ThenGetDomainError() {
        
        //Give
        self.useCaseStub.setError(error: DomainError.custom(message: "server error"))
        
        //Then
        sut.searchListRecipe(query: "pasta")
        
        //When
        
        XCTAssertTrue(self.sut.isError)
        XCTAssertEqual(self.sut.errorText, "server error")
    }
}

