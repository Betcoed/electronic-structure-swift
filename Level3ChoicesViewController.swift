//
//  Level3ChoicesViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 01/08/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class Level3ChoicesViewController: UIViewController {

    var startValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hardButton(sender: AnyObject) {
        startValue = 35
        performSegueWithIdentifier("Level3HardToShellsScreen", sender: self)
    }

    @IBAction func challengeButton(sender: AnyObject) {
        startValue = 36
        performSegueWithIdentifier("Level3ChallengeToNumberForm", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Level3HardToShellsScreen" {
          //  let DestViewController : ShellsViewController = segue.destinationViewController as! ShellsViewController
            let nav = segue.destinationViewController as! UINavigationController
            let DestViewController = nav.topViewController as! ShellsViewController            
            DestViewController.playChoice = Int(startValue)
        }
        if segue.identifier == "Level3ChallengeToNumberForm" {
            let DestViewController : NumberFormViewController = segue.destinationViewController as! NumberFormViewController
            DestViewController.playChoice = Int(startValue)
        }
    }
    

}
