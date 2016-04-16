//goodbye
//  ViewController.swift
//  Hockey
//
//  Created by Michael Maczynski on 4/11/16.
//  Copyright © 2016 JohnHerseyHighSchool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var array:[UIView] = []
    var hockeyStickArray:[UIView] = []
    var bothArray:[UIView] = []
    var allowsRotation = false
    var goalArray:[UIView] = []


    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior =
        UICollisionBehavior()

    @IBOutlet var puckImageView: UIImageView!
    @IBOutlet weak var hockeyStickView: UIView!
    @IBOutlet weak var puckView: UIView!
    @IBOutlet weak var goalView: UIView!
    
    @IBOutlet weak var backOfGoal: UIView!
    @IBOutlet weak var rightOfGoal: UIView!
    @IBOutlet weak var leftOfGoal: UIView!
    
    @IBOutlet weak var leftGoalPost: UIView!
    @IBOutlet weak var rightGoalPost: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)

        puckView.layer.cornerRadius = puckView.frame.size.width/2
        
        
        
//        array.append(puckView)
//        bothArray.append(puckView)
//        puckView.clipsToBounds = true
//        view.addSubview(puckView)
        
        array.append(puckImageView)
        bothArray.append(puckImageView)
        puckImageView.clipsToBounds = true
        view.addSubview(puckImageView)

        hockeyStickArray.append(hockeyStickView)
        hockeyStickView.clipsToBounds = true

        bothArray.append(hockeyStickView)

        view.addSubview(hockeyStickView)
        
        goalArray.append(goalView)
        bothArray.append(goalView)
        view.addSubview(goalView)
        
        goalArray.append(rightGoalPost)
        bothArray.append(rightGoalPost)
        view.addSubview(rightGoalPost)
        
        goalArray.append(leftGoalPost)
        bothArray.append(leftGoalPost)
        view.addSubview(leftGoalPost)
        
        
        
        goalArray.append(backOfGoal)
        bothArray.append(backOfGoal)
        view.addSubview(backOfGoal)
        
        goalArray.append(rightOfGoal)
        bothArray.append(rightOfGoal)
        view.addSubview(rightOfGoal)
        
        goalArray.append(leftOfGoal)
        bothArray.append(leftOfGoal)
        view.addSubview(leftOfGoal)
        

        addDynamicBehavior()

        puckView.backgroundColor = UIColor.whiteColor()

    }
    
    @IBAction func hockeyStickPanGestureRecognizer(sender: UIPanGestureRecognizer)
    {//
        let panGesture = sender.locationInView(view)
        hockeyStickView.center = CGPointMake(panGesture.x, hockeyStickView.center.y)
        dynamicAnimator.updateItemUsingCurrentState(hockeyStickView)
    }
    
    func addDynamicBehavior()
    {
        
        let stickDynamicItemBehavior = UIDynamicItemBehavior(items: hockeyStickArray)
        stickDynamicItemBehavior.density = 100000000000000000000.0
        stickDynamicItemBehavior.elasticity = 1.0
        stickDynamicItemBehavior.friction = 0.0
        stickDynamicItemBehavior.resistance = 0.0
        stickDynamicItemBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(stickDynamicItemBehavior)

        let goalDynamicItemBehavior = UIDynamicItemBehavior(items: goalArray)
        goalDynamicItemBehavior.density = 100000000000000000000.0
        goalDynamicItemBehavior.elasticity = 1.0
        goalDynamicItemBehavior.friction = 0.0
        goalDynamicItemBehavior.resistance = 0.0
        goalDynamicItemBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(goalDynamicItemBehavior)

        let puckDynamicItemBehavior = UIDynamicItemBehavior(items: array)
        puckDynamicItemBehavior.density = 1.0
        puckDynamicItemBehavior.elasticity = 1.0
        puckDynamicItemBehavior.friction = 0.0
        puckDynamicItemBehavior.resistance = 0.0
        puckDynamicItemBehavior.allowsRotation = false

        dynamicAnimator.addBehavior(puckDynamicItemBehavior)

        
        
        let pushBehavior = UIPushBehavior(items: array, mode: .Instantaneous)
        pushBehavior.magnitude = 1.5
        pushBehavior.pushDirection = CGVectorMake(0.5, 0.5)
        dynamicAnimator.addBehavior(pushBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: bothArray)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self

        dynamicAnimator.addBehavior(collisionBehavior)

    }
    func goal()
    {
        let alert = UIAlertController(title: "GOAL", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
        }))
        
        presentViewController(alert, animated: true, completion: nil)

    }

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        
        
        if item1.isEqual(puckImageView) && item2.isEqual(goalView) || item1.isEqual(goalView) && item2.isEqual(puckImageView)
        {
            goal()
        }
        else if item1.isEqual(puckImageView) && item2.isEqual(rightGoalPost) || item1.isEqual(rightGoalPost) && item2.isEqual(puckImageView)
        {
            goal()
        }
        else if item1.isEqual(puckImageView) && item2.isEqual(leftGoalPost) || item1.isEqual(leftGoalPost) && item2.isEqual(puckImageView)
        {
            goal()
        }
        
       }


















}
