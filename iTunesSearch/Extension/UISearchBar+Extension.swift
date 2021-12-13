//
//  UISearchBar+Extension.swift
//  iTunesSearch
//
//  Created by Dilek Eminoğlu on 13.12.2021.
//

import UIKit

extension UISearchBar {
    
    // MARK: - public Methods
    
    public func debounce(interval: Int, queue: DispatchQueue, action: @escaping (() -> Void)) -> () -> Void {
        let delay = DispatchTimeInterval.milliseconds(interval)
        var lastEditTime = DispatchTime.now()
        
        return {
            lastEditTime = DispatchTime.now()
            let dispatchTime: DispatchTime = DispatchTime.now() + delay
            
            queue.asyncAfter(deadline: dispatchTime) {
                let when: DispatchTime = lastEditTime + delay
                let now = DispatchTime.now()
                if now.rawValue >= when.rawValue {
                    action()
                }
            }
        }
    }
}
