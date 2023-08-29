//
//  Reachability.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Network

class Reachability {
    
    static let shared = Reachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isReachable: Bool = false
    
    private init() {
        self.monitor.pathUpdateHandler = { path in
            self.isReachable = path.status == .satisfied
            self.log(path)
        }
    }
    
    func start() {
        self.monitor.start(queue: self.queue)
    }
    
    func stop() {
        self.monitor.cancel()
    }
    
    private func log(_ path: NWPath) {
        var logs = "🌍"
        
        logs += " "
        if path.status == .satisfied {
            logs += "REACHABLE"
        } else {
            logs += "NOT REACHABLE"
        }
        
        logs += " --- "
        if path.isExpensive {
            logs += "IS EXPENSIVE (Cellular)"
        } else {
            logs += "NOT EXPENSIVE (Wifi)"
        }
        
        print(logs)
    }
    
}
