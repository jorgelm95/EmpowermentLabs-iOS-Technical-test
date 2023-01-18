//
//  RecipeDetailViewModelTest.swift
//  RecipeAppUITests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import XCTest

@testable import RecipeAppDomain
@testable import RecipeAppUI

final class RecipeDetailViewModelTest: XCTestCase {
    private var sut: RecipeDetailViewModel!
    private var useCaseStub: RecipeDetailUseCaseStub!

    override func setUp() {
        super.setUp()

        self.useCaseStub = RecipeDetailUseCaseStub()
        self.sut = RecipeDetailViewModel(useCase: useCaseStub)
    }

    override func tearDown() {
        self.sut = nil
        self.useCaseStub = nil

        super.tearDown()
    }
    
    func testGetRecipeById_WhenSentAValidRecipeId_ThenGetRecipeDetail() {
        //Give
        
        //Then
        sut.getRecipeById("1")
        
        
        //When
        XCTAssertNotNil(sut.recipeDetail)
    }
    
    func testGetRecipeById_WhenSentAValidRecipeId_ThenGetServerError() {
        
        //Give
        self.useCaseStub.setError(error: DomainError.custom(message: "server error"))
        
        //Then
        sut.getRecipeById("id")
        
        //When
        
        XCTAssertTrue(self.sut.isError)
        XCTAssertEqual(self.sut.errorText, "server error")
    }
}
