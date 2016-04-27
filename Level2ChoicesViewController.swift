//
//  Level2ChoicesViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 25/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class Level2ChoicesViewController: UIViewController {
    
    var startValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func easyButton(sender: AnyObject) {
        startValue = 21
        [self .performSegueWithIdentifier("Level2ChoicesToPENScreenSegue", sender: sender)]
    }
    
    
    @IBAction func mediumButton(sender: AnyObject) {
        startValue = 22
        [self .performSegueWithIdentifier("Level2ChoicesToPENScreenSegue", sender: sender)]
    }
    
    
    @IBAction func hardButton(sender: AnyObject) {
        startValue = 23
        [self .performSegueWithIdentifier("Level2ChoicesToPENScreenSegue", sender: sender)]
    }
    
    @IBAction func challengeButton(sender: AnyObject) {
        startValue = 24
        [self .performSegueWithIdentifier("Level2ChoicesToPENScreenSegue", sender: sender)]
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //let DestViewController : PENScreenViewController = segue.destinationViewController as! PENScreenViewController
       let nav = segue.destinationViewController as! UINavigationController
        let DestViewController = nav.topViewController as! PENScreenViewController
        
        DestViewController.playChoice = Int(startValue)
    }
    

}
