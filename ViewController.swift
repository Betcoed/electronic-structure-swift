//
//  ViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 12/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController,FirstScreenViewControllerDelegate {

    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var TutorialButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    var firstTime = true
    var startValue = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        #if Core
                 restorePurchasesButton.hidden = true
                #endif
        rotateView()
        
      /*  UIButton.animateWithDuration(2.0, delay: 0.0, options: .CurveLinear, animations: {
            self.PlayButton.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
            }, completion: {(Bool) in self.rotateImage()})  */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        func rotateView() {
        
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(M_PI * 2.0)
            rotationAnimation.duration = 3
            rotationAnimation.repeatCount = Float.infinity
            
            PlayButton.layer.addAnimation(rotationAnimation, forKey: nil)
            TutorialButton.layer.addAnimation(rotationAnimation, forKey: nil)
        }
    
    @IBAction func playButton(sender: AnyObject) {
        if firstTime == true {
            [self .performSegueWithIdentifier("directPlayToShellsSegue", sender: sender)]
        } else {
            [self .performSegueWithIdentifier("playToLevelChoicesSegue", sender: sender)]
        }
        
    }
    
    @IBAction func restorePurchases(sender: UIButton) {
    }
    
    
    func myVCShellsFromPlayDidFinish(controller: ShellsViewController, firstTimeFromShells: Bool) {
        
        firstTime = firstTimeFromShells
        controller.navigationController?.popViewControllerAnimated(true)
            }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "directPlayToShellsSegue" {
            let DestViewController = segue.destinationViewController as! ShellsViewController
            DestViewController.firstTimeShells = Bool(firstTime)
            DestViewController.playChoice = Int(startValue)
            let shellsVC = segue.destinationViewController as! ShellsViewController
            shellsVC.delegate = self
        }
        // let DestViewController = nav.topViewController as! ShellsViewController
        
        // var DestViewController : ShellsViewController = segue.destinationViewController as! ShellsViewController
        
    }
    
    }


