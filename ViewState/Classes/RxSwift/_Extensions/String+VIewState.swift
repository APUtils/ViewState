//
//  String+VIewState.swift
//  Pods
//
//  Created by Anton Plebanovich on 30.04.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

extension String {
    
    /// Returns fileName without extension
    var _fileName: String {
        guard let lastPathComponent = components(separatedBy: "/").last else { return "" }
        
        var components = lastPathComponent.components(separatedBy: ".")
        if components.count == 1 {
            return lastPathComponent
        } else {
            components.removeLast()
            return components.joined(separator: ".")
        }
    }
}
