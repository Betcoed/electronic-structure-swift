//
//  AtomsTutorialPg2ViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 14/08/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class AtomsTutorialPg2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextButtonClicked"), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextButtonClicked() {
        performSegueWithIdentifier("ToAtomsTutorialScreen3", sender: self)
        self.dismissViewControllerAnimated(true, completion: nil)
        // self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
