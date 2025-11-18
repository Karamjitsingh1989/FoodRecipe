//
//  Reachabilty.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Network

protocol ReachabiltyProtocol {
  func isNetworkReachable() -> Bool
}


class Reachabilty: ReachabiltyProtocol {
   
    private let moniter = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var isReachable: Bool = true
    
    init() {
        moniter.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied
        }
        moniter.start(queue: queue)
    }
    func isNetworkReachable() -> Bool {
        return isReachable
    }
}

