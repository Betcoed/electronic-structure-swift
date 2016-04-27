//
//  MediumLevel1ChoicesViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 23/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class MediumLevel1ChoicesViewController: UIViewController {

    var startValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EasierButton(sender: AnyObject) {
        
        startValue = 13
        [self .performSegueWithIdentifier("MediumLevel1ChoicesToShellsSegue", sender: sender)]
    }
    
    
    @IBAction func harderButton(sender: AnyObject) {
        
        startValue = 14
        [self .performSegueWithIdentifier("MediumLevel1ChoicesToShellsSegue", sender: sender)]
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nav = segue.destinationViewController as! UINavigationController
        let DestViewController = nav.topViewController as! ShellsViewController
       // let DestViewController : ShellsViewController = segue.destinationViewController as! ShellsViewController
        DestViewController.playChoice = Int(startValue)
    }
    

}
