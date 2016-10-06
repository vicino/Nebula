//
//  NetworkObserver.swift
//  Vicino
//
//  Created by Alois Barreras on 6/28/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import UIKit

/*
 * This code is taken from the Advanced NSOperations 2015 WWDC sample code
 **/
public class NetworkObserver: NSObject {
    public static func startObserving() {
        DispatchQueue.main.async {
            NetworkIndicatorController.sharedIndicatorController.networkActivityDidStart()
        }
    }
    
    public static func stopObserving() {
        DispatchQueue.main.async {
            NetworkIndicatorController.sharedIndicatorController.networkActivityDidEnd()
        }
    }
}

private class NetworkIndicatorController {
    
    static let sharedIndicatorController = NetworkIndicatorController()
    
    private var activityCount = 0
    
    private var visibilityTimer: Timer?
    
    func networkActivityDidStart() {
        assert(Thread.isMainThread, "Altering network activity indicator state can only be done on the main thread.")
        
        activityCount += 1
        
        updateIndicatorVisibility()
    }
    
    func networkActivityDidEnd() {
        assert(Thread.isMainThread, "Altering network activity indicator state can only be done on the main thread.")
        
        activityCount -= 1
        
        updateIndicatorVisibility()
    }
    
    private func updateIndicatorVisibility() {
        if activityCount > 0 {
            showIndicator()
        }
        else {
            /*
            To prevent the indicator from flickering on and off, we delay the
            hiding of the indicator by one second. This provides the chance
            to come in and invalidate the timer before it fires.
            */
            visibilityTimer = Timer(interval: 1.0) {
                self.hideIndicator()
            }
        }
    }
    
    private func showIndicator() {
        visibilityTimer?.cancel()
        visibilityTimer = nil
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func hideIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

class Timer {
    
    private(set) var isCancelled = false
    
    
    init(interval: TimeInterval, handler: @escaping ()->()) {
        let when = DispatchTime.now() + Double(Int64(interval * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: when) { [weak self] in
            if self?.isCancelled == false {
                handler()
            }
        }
    }
    
    func cancel() {
        isCancelled = true
    }
}
