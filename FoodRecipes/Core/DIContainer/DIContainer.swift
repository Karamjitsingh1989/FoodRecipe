//
//  DIContainer.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

protocol DependencyInjectionProtocol {
    func resolve<T>(_ type:T.Type) -> T
}


class DIContainer: DependencyInjectionProtocol {
    static let shared: DIContainer = .init()
    private var factories: [String: Any] = [:]
    private init() {}
    func register<T>(_ type:T.Type, _ factory:@escaping() -> T) {
        let key = String(describing:type)
        factories[key] = factory
    }
    func resolve<T>(_ type:T.Type) -> T {
        guard let factory = factories[String(describing: type)] as? () -> T else { fatalError("No factory registered for \(type)")}
        return factory()
    }
    
}
