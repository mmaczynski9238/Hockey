//
//  ViewController.swift
//  Hockey
//
//  Created by Michael Maczynski on 4/11/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()

    @IBOutlet weak var hockeyStickView: UIView!
    @IBOutlet weak var puckView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func hockeyStickPanGestureRecognizer(sender: UIPanGestureRecognizer) {
        let panGesture = sender.locationInView(view)
        hockeyStickView.center = CGPointMake(panGesture.x, hockeyStickView.center.y)
        dynamicAnimator.updateItemUsingCurrentState(hockeyStickView)
    }
    
    
    
}

