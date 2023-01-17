//
//  BaseUseCase.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine

protocol BaseUseCaseType {
    associatedtype Response
    associatedtype Params

    func execute(params: Params) -> AnyPublisher<Response, DomainError>
}

public class BaseUseCase<R, P>: BaseUseCaseType {
    
    private var cancelable = Set<AnyCancellable>()
    
    public typealias Response = R
    public typealias Params = P

    public init() {}
    
    open func execute(params: P) -> AnyPublisher<R, DomainError> {
        buildUseCase(params: params)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    open func buildUseCase(params: Params) -> AnyPublisher<Response, DomainError> {
        preconditionFailure("This must be overriden.")
    }
}
