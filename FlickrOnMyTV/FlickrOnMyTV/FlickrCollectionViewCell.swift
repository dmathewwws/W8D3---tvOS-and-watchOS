//
//  FlickrCollectionViewCell.swift
//  FlickrOnMyTV
//
//  Created by Daniel Mathews on 2015-12-08.
//  Copyright © 2015 Daniel Mathews. All rights reserved.
//

import UIKit

class FlickrCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var downloadTask:NSURLSessionDownloadTask!
    
//    override func canBecomeFocused() -> Bool {
//        return true
//    }
//    
//    
//    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
//        
//        if context.nextFocusedView == self {
//            
//            coordinator.addCoordinatedAnimations({ () -> Void in
//                
//                self.layer.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.2).CGColor
//                
//                }, completion: nil)
//            
//        } else if context.previouslyFocusedView == self {
//            
//            coordinator.addCoordinatedAnimations({ () -> Void in
//                
//                self.layer.backgroundColor = UIColor.clearColor().CGColor
//                
//                }, completion: nil)
//            
//        }
//        
//    }
    
}
