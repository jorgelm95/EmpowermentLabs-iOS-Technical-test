//
//  RecipeDetailUseCaseTest.swift
//  RecipeAppDomainTests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine
import XCTest

@testable import RecipeAppDomain

final class RecipeDetailUseCaseTest: XCTestCase {
    private var sut: RecipeDetailUseCase!
    private var repositoryStub: RecipeDetailRespositoryStub!
    private var cancellable: AnyCancellable?
    override func setUp() {
        super.setUp()

        self.repositoryStub = RecipeDetailRespositoryStub()
        self.sut = RecipeDetailUseCase(repository: self.repositoryStub)
    }

    override func tearDown() {
        self.sut = nil
        self.repositoryStub = nil

        super.tearDown()
    }

    func testBuildUseCase_WhenIsSuccess_ThenReturnRecipeDetail() {
        //Give
        let expectation = XCTestExpectation(description: "Wait for success result use case.")
        var result: RecipeDetail?

        // when
        self.cancellable = self.sut.execute(params: "1").sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .finished:
                break
            }
        }) { recipeDetailResult in
            result = recipeDetailResult
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)

        // Then
        XCTAssertNotNil(result)
    }

    func testBuildUseCase_WhenFail_ThenReturnDomainError() {
        
        //Give
        let expectation = XCTestExpectation(description: "Wait for fail use case.")
        var errorResponse: DomainError?

        self.repositoryStub.setError(error: NetworkServiceError.customError(message: "404"))
        
        // when
        self.cancellable = self.sut.execute(params: "1").sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                errorResponse = error
                expectation.fulfill()
            case .finished:
                break
            }
        }) { recipeDetailResult in
            XCTFail("this deberia falla")
        }

        wait(for: [expectation], timeout: 1.0)

        //Then
        XCTAssertNotNil(errorResponse)
        XCTAssertEqual(errorResponse, DomainError.custom(message: "The recipe was not found."))
    }
}
