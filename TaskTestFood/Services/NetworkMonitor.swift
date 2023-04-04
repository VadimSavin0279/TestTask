//
//  NetworkMonitor.swift
//  TaskTestFood
//
//  Created by 123 on 04.04.2023.
//

import Foundation
import Network

open class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected = false
    private init() {
        monitor = NWPathMonitor()
    }
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            DispatchQueue.main.async {
                NotificationCenter.default.post(name:
                                                    Notification.Name("ConnectionDidChange"),
                                                object: self,
                                                userInfo: nil)
            }
        }
    }
    public func stopMonitoring() {
        monitor.cancel()
    }
}
