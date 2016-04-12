//
//  ViewController.swift
//  Hockey
//
//  Created by Michael Maczynski on 4/11/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior = UICollisionBehavior()

    @IBOutlet weak var hockeyStickView: UIView!
    @IBOutlet weak var puckView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        puckView.backgroundColor = UIColor.blueColor()
        view.addSubview(puckView)
        
       // addDynamicBehavior(puckView)
    }

    @IBAction func hockeyStickPanGestureRecognizer(sender: UIPanGestureRecognizer) {
        let panGesture = sender.locationInView(view)
        hockeyStickView.center = CGPointMake(panGesture.x, hockeyStickView.center.y)
        dynamicAnimator.updateItemUsingCurrentState(hockeyStickView)
    }

    func addDynamicBehavior(array: [UIView]){
        let dynamicItemBehavior = UIDynamicItemBehavior(items: array)
        dynamicItemBehavior.density = 1.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicItemBehavior.friction = 0.0
        dynamicItemBehavior.resistance = 0.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        let pushBehavior = UIPushBehavior(items: array, mode: .Instantaneous)
        pushBehavior.magnitude = 1.0
        pushBehavior.pushDirection = CGVectorMake(0.5, 0.5)
        dynamicAnimator.addBehavior(pushBehavior)
        
        
        let collisionBehavior = UICollisionBehavior(items: array)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)

}
}