//
//  LevelCompletedViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 06/08/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class LevelCompletedViewController: UIViewController {
    
    var playChoice = 0
    var firstTimeCompletedLevel = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToChoicesButton(sender: AnyObject) {
       self.dismissViewControllerAnimated(true, completion: nil)
              switch playChoice {
            case 11:
            //go to easy level1 choices
                if firstTimeCompletedLevel == true {
                    firstTimeCompletedLevel = false
                  [self .performSegueWithIdentifier("CompletedLevelToFirstSegue", sender: sender)]  
                } else {
            [self .performSegueWithIdentifier("LevelCompletedToEasyLevel1Choices", sender: sender)]
                }
            break
        case 13:
            //go to medium level1 choices
            [self .performSegueWithIdentifier("LevelCompletedToMediumLevel1Choices", sender: sender)]
            break
        case 31:
            //go to easy level3 choices
            [self .performSegueWithIdentifier("LevelCompletedToEasyLevel3Choices", sender: sender)]
            break
        case 33:
            //go to medium level3 choices
            [self .performSegueWithIdentifier("LevelCompletedToMediumLevel3Choices", sender: sender)]            
            break
        case 21...24:
            //[self .performSegueWithIdentifier("LevelCompletedLevel2Choices", sender: sender)]
            performSegueWithIdentifier("LevelCompletedLevel2Choices", sender: self)
        default:
            //go back to play/tutorial screen
            break
            }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "CompletedLevelToFirstSegue" {
            let DestViewController : ViewController = segue.destinationViewController as! ViewController
            DestViewController.firstTime = Bool(firstTimeCompletedLevel)
        }
    }
    

}
