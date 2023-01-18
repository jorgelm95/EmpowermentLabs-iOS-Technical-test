//
//  RecipeListUseCaseTest.swift
//  RecipeAppDomainTests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine
import XCTest

@testable import RecipeAppDomain

final class RecipeListUseCaseTest: XCTestCase {
    private var sut: RecipeListUseCase!
    private var repositoryStub: RecipeListRespositoryStub!
    private var cancellable: AnyCancellable?
    override func setUp() {
        super.setUp()

        self.repositoryStub = RecipeListRespositoryStub()
        self.sut = RecipeListUseCase(repository: self.repositoryStub)
    }

    override func tearDown() {
        self.sut = nil
        self.repositoryStub = nil

        super.tearDown()
    }

    func testBuildUseCase_WhenIsSuccess_ThenReturnRecipeResult() {
        //Give
        let expectation = XCTestExpectation(description: "Wait for success result use case.")
        var result: RecipeResult?

        // when
        self.cancellable = self.sut.execute(params: SearchRecipeParams(query: "pasta", paging: nil)).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .finished:
                break
            }
        }, receiveValue: { recipeResult in
            result = recipeResult
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)

        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.results.count, 2)
    }

    func testBuildUseCase_WhenFail_ThenReturnDomainError() {
        
        //Give
        let expectation = XCTestExpectation(description: "Wait for fail use case.")
        var errorResponse: DomainError?

        self.repositoryStub.setError(error: NetworkServiceError.customError(message: "404"))
        
        // when
        self.cancellable = self.sut.execute(params: SearchRecipeParams(query: "pasta", paging: nil)).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                errorResponse = error
                expectation.fulfill()
            case .finished:
                break
            }
        }) { recipeResult in
            XCTFail("esto deberia fallar")
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        //Then
        XCTAssertNotNil(errorResponse)
        XCTAssertEqual(errorResponse, DomainError.custom(message: "there are not more recipes."))
    }
}
