//
//  EasyLevel1ChoicesViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 15/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class EasyLevel1ChoicesViewController: UIViewController {
    
    var startValue = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      //  [self.navigationController setNavigationBarHidden:NO animated:YES]
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func veryEasyButton(sender: AnyObject) {
        startValue = 11
        [self .performSegueWithIdentifier("EasyLevel1ChoicesToShellsSegue", sender: sender)]
        
    }
    
    @IBAction func aLittleHarderButton(sender: AnyObject) {
        startValue = 12
        [self .performSegueWithIdentifier("EasyLevel1ChoicesToShellsSegue", sender: sender)]
        
    }
    
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nav = segue.destinationViewController as! UINavigationController
        let DestViewController = nav.topViewController as! ShellsViewController
        
       // var DestViewController : ShellsViewController = segue.destinationViewController as! ShellsViewController
        DestViewController.playChoice = Int(startValue)
        
    }
    

}
