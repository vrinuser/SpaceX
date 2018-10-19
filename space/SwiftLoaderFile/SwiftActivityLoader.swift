
//
//  SwiftActivityLoader.swift
//  SingleltonDemo
//
//  Created by Nick on 20/06/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import UIKit

class SwiftActivityLoader: NSObject {
    
    //MARK:- Start ActivityLoader
    class func startActivityLoader(onView : UIView) -> UIView {
        
        let activityLoaderView = UIView.init(frame: onView.bounds)
        activityLoaderView.backgroundColor = UIColor.white
            //UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityLoader = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityLoader.color = UIColor.init(red: 52.0/255.0, green: 44.0/255.0, blue: 81.0/255.0, alpha: 1)
        activityLoader.startAnimating()
        activityLoader.center = activityLoaderView.center
        
        DispatchQueue.main.async {
            activityLoaderView.addSubview(activityLoader)
            onView.addSubview(activityLoaderView)
        }
        
        return activityLoaderView
    }
  
    //MARK:- Stop ActivityLoader
    class func stopActivityLoader(loaderView :UIView) {
        DispatchQueue.main.async {
            loaderView.removeFromSuperview()
        }
    }
    
    
}

