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
    var goalieArray:[UIView] = []
    var goalieCollisionArray:[UIView] = []
    var shelfArray:[UIView] = []

    
    var bothArray:[UIView] = []
    var allowsRotation = false
    var goalArray:[UIView] = []

    var dynamicAnimator = UIDynamicAnimator()
    var collisionBehavior =
        UICollisionBehavior()

    @IBOutlet weak var topShelf: UIView!
    @IBOutlet weak var bottomShelf: UIView!
    
    var ScoreString = ""
    var HighscoreString = ""
    
    
    
    @IBOutlet weak var goalie: UIImageView!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var goals = 0
    var highscoreVariable = 1
    
    @IBOutlet var oldPuckImageView: UIImageView!
    
    @IBOutlet weak var hockeyStickView: UIView!
    @IBOutlet weak var puckView: UIView!
    
    var puckImageView = UIImageView()
    
    
    @IBOutlet weak var backOfGoal: UIView!
    @IBOutlet weak var rightOfGoal: UIView! //invisible views
    @IBOutlet weak var leftOfGoal: UIView!
    
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var leftGoalPost: UIView! //goal
    @IBOutlet weak var rightGoalPost: UIView!
    
    @IBOutlet var numberOfGoalsTextField: UILabel!
    @IBOutlet var startButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        array.append(puckImageView); bothArray.append(puckImageView)
        goalieArray.append(goalie); bothArray.append(goalie); goalieCollisionArray.append(goalie)

        goalieCollisionArray.append(topShelf)
        goalieCollisionArray.append(bottomShelf)
        shelfArray.append(bottomShelf)
        shelfArray.append(topShelf)


        
        //Load Score
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var score = defaults.valueForKey("Score")?.integerValue ?? 0
        defaults.synchronize()
        goals = score
        
        //Load Highscore
        let SecondDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var highscore = SecondDefaults.valueForKey("Highscore")?.integerValue ?? 0
        SecondDefaults.synchronize()
        highscoreVariable = highscore
        
        //Set Score Text
        ScoreString = String(goals)
        numberOfGoalsTextField.text = "Number of Goals: " + ScoreString
        
        oldPuckImageView.alpha = 0.0

        drawPuck()
        
        puckImageView.alpha = 0.0

        hockeyStickArray.append(hockeyStickView); bothArray.append(hockeyStickView); view.addSubview(hockeyStickView)
        hockeyStickView.clipsToBounds = true;
        
        goalArray.append(goalView);         bothArray.append(goalView);       view.addSubview(goalView)
        
        goalArray.append(rightGoalPost);    bothArray.append(rightGoalPost);  view.addSubview(rightGoalPost)
        
        goalArray.append(leftGoalPost);     bothArray.append(leftGoalPost);   view.addSubview(leftGoalPost)
        
        goalArray.append(backOfGoal);       bothArray.append(backOfGoal);     view.addSubview(backOfGoal)
        
        goalArray.append(rightOfGoal);      bothArray.append(rightOfGoal);    view.addSubview(rightOfGoal)
        
        goalArray.append(leftOfGoal);       bothArray.append(leftOfGoal);     view.addSubview(leftOfGoal)
        
        addDynamicBehavior()
        
        
        self.HighscoreString = String(self.highscoreVariable)
        self.highscoreLabel.text = "Highscore: " + self.HighscoreString
    }
    
    func drawPuck()
    {
        puckImageView.frame = CGRect(x: 357, y: 492, width: 55, height: 40)
        view.addSubview(puckImageView)
        
        puckImageView.image = UIImage(named:"puck.png")
    }
    
    @IBAction func hockeyStickPanGestureRecognizer(sender: UIPanGestureRecognizer)
    {
        let panGesture = sender.locationInView(view)
        hockeyStickView.center = CGPointMake(panGesture.x, hockeyStickView.center.y)
        dynamicAnimator.updateItemUsingCurrentState(hockeyStickView)
    }
    
    func addDynamicBehavior()
    {
        let stickDynamicItemBehavior = UIDynamicItemBehavior(items: hockeyStickArray);      let puckDynamicItemBehavior = UIDynamicItemBehavior(items: array)
        stickDynamicItemBehavior.density = 100000000000000000000.0;                         puckDynamicItemBehavior.density = 0.5
        stickDynamicItemBehavior.elasticity = 1.0;                                          puckDynamicItemBehavior.elasticity = 1.0
        stickDynamicItemBehavior.friction = 0.0;                                            puckDynamicItemBehavior.friction = 0.0
        stickDynamicItemBehavior.resistance = 0.0;                                          puckDynamicItemBehavior.resistance = 0.0
        stickDynamicItemBehavior.allowsRotation = false;                                    puckDynamicItemBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(stickDynamicItemBehavior);                              dynamicAnimator.addBehavior(puckDynamicItemBehavior)

        let goalDynamicItemBehavior = UIDynamicItemBehavior(items: goalArray);              let goalieDynamicItemBehavior = UIDynamicItemBehavior(items: goalieArray)
        goalDynamicItemBehavior.density = 100000000000000000000.0;                          goalieDynamicItemBehavior.density = 1.0
        goalDynamicItemBehavior.elasticity = 1.0;                                           goalieDynamicItemBehavior.elasticity = 1.0
        goalDynamicItemBehavior.friction = 0.0;                                             goalieDynamicItemBehavior.friction = 0.0
        goalDynamicItemBehavior.resistance = 0.0;                                           goalieDynamicItemBehavior.resistance = 0.0
        goalDynamicItemBehavior.allowsRotation = false;                                     goalieDynamicItemBehavior.allowsRotation = false
        dynamicAnimator.addBehavior(goalDynamicItemBehavior);                               dynamicAnimator.addBehavior(goalieDynamicItemBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: bothArray)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        
        let goalieCollisionBehavior = UICollisionBehavior(items: goalieCollisionArray)
        goalieCollisionBehavior.translatesReferenceBoundsIntoBoundary = true
        goalieCollisionBehavior.collisionMode = .Everything
        goalieCollisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(goalieCollisionBehavior)
        
        
        let shelfDynamicItemBehavior = UIDynamicItemBehavior(items: shelfArray);
        shelfDynamicItemBehavior.density = 100000000000000000000.0;
        shelfDynamicItemBehavior.elasticity = 1.0;
        shelfDynamicItemBehavior.friction = 0.0;
        shelfDynamicItemBehavior.resistance = 0.0;
        shelfDynamicItemBehavior.allowsRotation = false;
        dynamicAnimator.addBehavior(shelfDynamicItemBehavior);
        
    }
    
    func pushPuck()
    {
        let pushBehavior = UIPushBehavior(items: array, mode: .Instantaneous)
        pushBehavior.magnitude = 1.5
        pushBehavior.pushDirection = CGVectorMake(0.5, 0.5)
        dynamicAnimator.addBehavior(pushBehavior)
    }
   
    func moveGoalie()
    {
        let goaliePush = UIPushBehavior(items: goalieArray, mode: .Instantaneous)
        goaliePush.magnitude = 1.5
        goaliePush.pushDirection = CGVectorMake(1.0, 0.0)
        dynamicAnimator.addBehavior(goaliePush)
    }

    func goal()
    {
        let alert = UIAlertController(title: "GOAL", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: { (UIAlertAction) -> Void in
            
        self.dynamicAnimator.updateItemUsingCurrentState(self.puckImageView)
        self.drawPuck()
        self.checkHighscore()
            }))
        presentViewController(alert, animated: true, completion: nil)
        
        
        self.collisionBehavior.removeItem(puckImageView)
        self.puckImageView.removeFromSuperview()
        dynamicAnimator.updateItemUsingCurrentState(puckImageView)
        moveGoalie()
        checkHighscore()
        
        goals += 1
        
        //Set Score Text
        ScoreString = String(goals)
        numberOfGoalsTextField.text = "Number of Goals: " + ScoreString

        
        numberOfGoalsTextField.text = "Number of Goals: \(goals)"
        
    }

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        
        if item1.isEqual(puckImageView) && item2.isEqual(goalView) || item1.isEqual(goalView) && item2.isEqual(puckImageView)
        {
            goal()
        }
//        else if item1.isEqual(puckImageView) && item2.isEqual(rightGoalPost) || item1.isEqual(rightGoalPost) && item2.isEqual(puckImageView)
//        {
//            goal()
//        }
//        else if item1.isEqual(puckImageView) && item2.isEqual(leftGoalPost) || item1.isEqual(leftGoalPost) && item2.isEqual(puckImageView)
//        {
//            goal()
//        }
        
       }


    @IBAction func startButton(sender: UIButton) {
        puckImageView.alpha = 1.0
        pushPuck()
        startButtonOutlet.alpha = 0.0
        moveGoalie()

    }

    @IBAction func saveButton(sender: UIButton) {
        
    }


    func resetHighscore()
    {
        highscoreVariable = goals
        let SecondDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        SecondDefaults.setObject(highscoreVariable, forKey: "Highscore")
        SecondDefaults.synchronize()
        HighscoreString = String(highscoreVariable)
        highscoreLabel.text = "Highscore: " + HighscoreString
        if highscoreVariable >= goals {
            HighscoreString = String(self.highscoreVariable)
            highscoreLabel.text = "Highscore: " + HighscoreString
        }
    }
    

    
    func checkHighscore()
    {
        
        //Update Highscore if Score is bigger
        if goals > highscoreVariable {
        
        //Set Highscore to Score
        highscoreVariable = goals
        
        //Save Highscore
        let SecondDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        SecondDefaults.setObject(HighscoreString, forKey: "Highscore")
        SecondDefaults.synchronize()
        
        //Set Highscore Text
        HighscoreString = String(highscoreVariable)
        highscoreLabel.text = "Highscore: " + HighscoreString
        
        //NewHighscoreLabel.text = "New Highscore"
        }
        //Set Highscore Text if Score is smaller
        else if highscoreVariable >= goals {
            HighscoreString = String(self.highscoreVariable)
            highscoreLabel.text = "Highscore: " + HighscoreString
        }
        
        
        
    }
    
}


