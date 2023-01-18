//
//  BaseUseCaseStub.swift
//  RecipeAppUITests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine

@testable import RecipeAppDomain
@testable import RecipeAppUI

public class BaseUseCaseStub<R, P>: BaseUseCase<R, P> {
    private var cancelableTest = Set<AnyCancellable>()
    
    public override func execute(params: P) -> AnyPublisher<R, DomainError> {
        buildUseCase(params: params)
            .receive(on: ImmediateScheduler.shared)
            .eraseToAnyPublisher()
    }
}
