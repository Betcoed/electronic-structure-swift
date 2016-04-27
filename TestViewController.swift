//
//  TestViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 26/08/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cyanball: UIImageView!
    
    var locationOfTouch = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Below line causes alignment to go wrong, but allows ball to remain in moved position
        mainView.translatesAutoresizingMaskIntoConstraints = true
        
        print("mainView height =  \(mainView.bounds.height)")
        print("mainView origin =  \(mainView.bounds.origin.x)")
        print("mainView origin =  \(mainView.bounds.origin.y)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch : UITouch! = touches.anyObject() as! UITouch
        
        locationOfTouch = touch.locationInView(mainView)
        cyanball.center = locationOfTouch
    }
*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
