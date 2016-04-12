//
//  ViewController.swift
//  Hockey
//
//  Created by Michael Maczynski on 4/11/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// must be >= 1.0
    var snapX:CGFloat = 40.0
    
    /// must be >= 1.0
    var snapY:CGFloat = 1.0
    
    /// how far to move before dragging
    var threshold:CGFloat = 0.0
    
    /// the guy we're dragging
    var selectedView:UIView?
    
    /// drag in the Y direction?
    var shouldDragY = true
    
    /// drag in the X direction?
    var shouldDragX = true
    

    
    
    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()

    @IBOutlet weak var playerOneView: UIView!
    @IBOutlet weak var playerTwoView: UIView!
    @IBOutlet weak var puckView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /******Turn UIViews into Circles******/
        playerOneView.layer.cornerRadius = playerOneView.frame.size.width/2
        playerOneView.clipsToBounds = true
        
        playerTwoView.layer.cornerRadius = playerTwoView.frame.size.width/2
        playerTwoView.clipsToBounds = true
        
        puckView.layer.cornerRadius = puckView.frame.size.width/2
        puckView.clipsToBounds = true
        /************************************/


        
    }

    
    /**********Set Orientation**********/

    override func shouldAutorotate() -> Bool {
        return true
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight]
    }
    /************************************/

    
    
    
    
}

