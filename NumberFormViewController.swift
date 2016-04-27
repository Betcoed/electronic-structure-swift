//
//  NumberFormViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 04/08/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit
import AVFoundation

class NumberFormViewController: UIViewController, PENScreenViewControllerDelegate {
    
    @IBOutlet weak var elementIonImage: UIImageView!
    @IBOutlet weak var shell1TextBox: UITextField!
    @IBOutlet weak var shell2TextBox: UITextField!
    @IBOutlet weak var shell3TextBox: UITextField!
    @IBOutlet weak var shell4TextBox: UITextField!
    
    var NumberFormTextBoxes: [UITextField] = []
    var correctSound = AVAudioPlayer()
    var incorrectSound = AVAudioPlayer()
    
    var playChoice = Int()
    var textBoxInput: [Int] = []
    var atomicnumber = 0
    var fromPreviousInPENScreen = false
    var numbersPresent = true
    
    var elementImagesArray:[String] = ["hydrogen","hydrogen","helium","lithium","beryllium","boron","carbon","nitrogen","oxygen","fluorine","neon","sodium","magnesium","aluminium","silicon","phosphorus","sulphur","chlorine","argon","potassium","calcium","hydrogen_pos","Hydrogen_neg","Lithium_pos","Beryllium_pos","nitrogen_neg","oxygen_neg","fluorine_neg","sodium_pos","magnesium_pos","aluminium_pos","phosphorus_neg","sulphur_neg","chlorine_neg","potassium_pos","calcium_pos"]
    
    func myVCDidFinish(controller: PENScreenViewController, elementNumber: Int, fromPreviousInPENScreen: Bool) {
        
        atomicnumber = elementNumber
        controller.navigationController?.popViewControllerAnimated(true)
        NumberFormTextBoxes = [shell1TextBox, shell2TextBox, shell3TextBox, shell4TextBox]
        resetForNewElement()
        textBoxInput = [0,0,0,0]
        self.elementIonImage.image = UIImage(named: elementImagesArray[atomicnumber])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NumberFormTextBoxes = [shell1TextBox, shell2TextBox, shell3TextBox, shell4TextBox]
        atomicnumber = Int(arc4random_uniform(35))
        textBoxInput = [0,0,0,0]
        self.elementIonImage.image = UIImage(named: elementImagesArray[atomicnumber])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        NumberFormTextBoxes[2].resignFirstResponder()
        
        return true
    }
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        resetForNewElement()
    }
    
    @IBAction func checkButton(sender: AnyObject) {
        //set TextViews so that if a user has put nothing in a box, then this is translated as zero
        numbersPresent = true
       retrieveNumbers()
      //  changeToNumbers()
        //which method is called here depends on whether the image shown is an atom or an ion
        if numbersPresent == true {
        if (atomicnumber <= 20) {
            checkAtomsInNumberForm()
        } else {
            checkIonsInNumberForm()
        }
        }
    }
    
    func retrieveNumbers() {
        
        for var i=0; i<4; i++ {
            if NumberFormTextBoxes[i].text!.isEmpty {
                NumberFormTextBoxes[i].text = "0"
            }
        }
        
        let shell1TextFieldasNumber : Int? = Int(shell1TextBox.text!)
        let shell2TextFieldasNumber : Int? = Int(shell2TextBox.text!)
        let shell3TextFieldasNumber : Int? = Int(shell3TextBox.text!)
        let shell4TextFieldasNumber : Int? = Int(shell4TextBox.text!)
         var shellsTextFieldNumbers = [shell1TextFieldasNumber,shell2TextFieldasNumber,shell3TextFieldasNumber, shell4TextFieldasNumber]
        
        if  shell1TextFieldasNumber == nil || shell2TextFieldasNumber == nil || shell3TextFieldasNumber == nil || shell4TextFieldasNumber == nil {
            setAlertIncorrect("Warning", messageText: "Each text box must contain a number")
            for var i=0;i<4; i++ {
                if shellsTextFieldNumbers[i] == nil {
                    NumberFormTextBoxes[i].textColor = UIColor.redColor()
                }
            }
            numbersPresent = false
        } else {
            textBoxInput[0] = shell1TextFieldasNumber!
            textBoxInput[1] = shell2TextFieldasNumber!
            textBoxInput[2] = shell3TextFieldasNumber!
            textBoxInput[3] = shell4TextFieldasNumber!
        }
    }

    //this method checks if the user has typed in the correct numbers, if the symbol shown is an atom.
    func checkAtomsInNumberForm() {
    
    //change text added to numbers
    
    //first check something other than zero has been typed into the first shell box
    if textBoxInput[0] == 0 {
            setIncorrect("This element requires electrons in shell 1", shellTextBox: 0)
    //now check H and He
    } else if atomicnumber == 1 || atomicnumber == 2 {
    //H and He shouldn't have any electrons in shells 2, 3 or 4
    if textBoxInput[1] == 0 && textBoxInput[2] == 0 &&
    textBoxInput[3] == 0 {
    // the '1' below refers to the real shell number, not the number in an array.
        mayBeCorrect("1", shellnumberInt: 1)
    } else {
        setIncorrect("This element has no electrons in shells 2, 3 or 4", shellTextBox: 1)
        NumberFormTextBoxes[2].textColor = UIColor.redColor()
        NumberFormTextBoxes[3].textColor = UIColor.redColor()
        }
    } else
    //checking period 2 elements
    if atomicnumber >= 3 && atomicnumber <= 10 {
    //period 2 elements shouldn't have any electrons in shells 3 and 4
    if (textBoxInput[2] == 0 &&
    textBoxInput[3] == 0) {
    //period 2 elements should have 2 electrons in shell 1
    if textBoxInput[0] == 2 {
    // the '2' below refers to the real shell number, not the number in an array.
    mayBeCorrect("2",shellnumberInt: 2)
    } else {
        setIncorrect("This element has 2 electrons in shell 1", shellTextBox: 0)
    // shellEditText[0].setTextColor(Color.RED);
    }
    } else {
        setIncorrect("This element has no electrons in shells 3 or 4", shellTextBox: 2)
        NumberFormTextBoxes[3].textColor = UIColor.redColor()
        }
    } else
    //checking period 3 element
    if atomicnumber >= 11 && atomicnumber <= 18 {
    //period 3 elements shouldn't have any electrons in shell 4
    
    if textBoxInput[3] == 0 {
    
    //period 3 elements should have 8 electrons in shell 2
    if textBoxInput[1] == 8 {
    
    //period 3 elements should have 2 elecrons in shell 1
    if textBoxInput[0] == 2 {
    
    // the '3' below refers to the real shell number, not a number in an array.
    mayBeCorrect("3",shellnumberInt: 3)
    } else {
    //this just brings up the incorrect sad face with "2 electrons in shell 1 are required
    
    setIncorrect("This element has 2 electrons in shell 1", shellTextBox: 0);
    }
    } else {
        setIncorrect("This element has 8 electrons in shell 2", shellTextBox: 1);
    // shellEditText[1].setTextColor(Color.RED);
    }
    
    } else {
        setIncorrect("This element has no electrons in shell 4", shellTextBox: 3);
    // shellEditText[3].setTextColor(Color.RED);
    }
    } else
    //checking K and Ca
    if atomicnumber == 19 || atomicnumber == 20 {
    //K and Ca should have 2 electrons in shell 1, and 8 electrons in shells 2 and 3
    if textBoxInput[1] == 8 && textBoxInput[2] == 8 {
    if textBoxInput[0] == 2 {
    // the '4' below refers to the real shell number, not a number in an array.
        mayBeCorrect("4",shellnumberInt: 4)
    } else {
    // twoElecsInShell1();
    setIncorrect("This element has 2 electrons in shell 1", shellTextBox: 0);
    }
    } else {
        setIncorrect("This element has 8 electrons in shells 2 and 3", shellTextBox: 1);
    //set text colour to red
        }
    }
    }
    
    func checkIonsInNumberForm() {
    if textBoxInput[3] != 0 {
        setIncorrect("This ion has no electrons in shell 4", shellTextBox: 3)
    } else if textBoxInput[0] == 1 {
    setIncorrect("Wrong number of electrons in shell 1", shellTextBox: 0)
    } else if textBoxInput[2] != 0 {
    if atomicnumber >= 21 && atomicnumber <= 30 {
    setIncorrect("There are no electrons in shell 3", shellTextBox: 2)
    } else if atomicnumber >= 30 && atomicnumber <= 35 {
    if textBoxInput[2] != 8 {
    setIncorrect("There are 8 electrons in shell 3", shellTextBox: 2);
    } else if textBoxInput[3] == 0 && textBoxInput[1] == 8 && textBoxInput[0] == 2 {
    setAlertCorrect("Correct!", messageText: "Well Done!")
    } else {
    setIncorrect("Wrong number of electrons in shell 1 or 2", shellTextBox: 0)
        NumberFormTextBoxes[1].textColor = UIColor.redColor()
    }
    }
    } else if textBoxInput[1] != 0 {
    if atomicnumber >= 21 && atomicnumber <= 24 {
    setIncorrect("There are no electrons in shell 2", shellTextBox: 1);
    } else if atomicnumber >= 25 && atomicnumber <= 30 {
    if textBoxInput[1] != 8 {
    setIncorrect("There are 8 electrons in shell 2", shellTextBox: 1)
    } else if textBoxInput[3] == 0 && textBoxInput[0] == 2 && textBoxInput[2] == 0 {
    setAlertCorrect("Correct!", messageText: "Well Done!")
    } else {
    setIncorrect("Wrong number of electrons in shell 1", shellTextBox: 0)
    }
    } else if atomicnumber >= 31 && atomicnumber <= 35 {
        setIncorrect("There are 8 electrons in shell 3", shellTextBox: 2)
    }
    } else if textBoxInput[0] != 0 {
    if atomicnumber >= 25 && atomicnumber <= 35 {
    setIncorrect("There are 8 electrons in shell 2", shellTextBox: 1)
    } else if atomicnumber == 21 {
    setIncorrect("There are no electrons in shell 1", shellTextBox: 0)
    } else if atomicnumber >= 22 && atomicnumber <= 24 {
    if textBoxInput[0] == 2 {
    setAlertCorrect("Correct!", messageText: "Well Done!")
    } else {
    setIncorrect("There are 2 electrons in shell 1", shellTextBox: 0)
    }
    }
    } else if textBoxInput[0] == 0 {
    if atomicnumber == 21 {
    setAlertCorrect("Correct!", messageText: "Well Done!")
    } else {
    setIncorrect("Type the number of electrons that go in each shell", shellTextBox: 0)
    }
    }
    
    }
    func setIncorrect(hint: String, shellTextBox: Int) {
        //set colour of wrong number to red
        NumberFormTextBoxes[shellTextBox].textColor = UIColor.redColor()
        //bring up alert to say incorrect, with reason
        setAlertIncorrect("Incorrect", messageText: hint)
    }
    
    func setAlertIncorrect(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            
        }
        //change height of alert controller
       // let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.8, constant: self.view.frame.height * 0.40)
        
       // alertController.view.addConstraint(height);
        
        // Present Alert Controller
        self.presentViewController(alertController, animated: true, completion: nil)
       // let sadfaceImage = UIImage(named: "sadface")
        
       // let imageView = UIImageView(frame: CGRectMake(110, 80, 60, 60))
       // imageView.image = sadfaceImage
        
        //alert.view.addSubview(imageView)
       // alertController.view.addSubview(imageView)
        // Add Actions
        alertController.addAction(okAction)
        //set sound file name and extension
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("negativebeep", ofType: "wav")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        
      //  var error: NSError?
        /*
        do {
            //play sound
            incorrectSound = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch var error1 as NSError {
            error = error1
            incorrectSound = nil
        }
*/
        
        // Preparation
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        // Play the sound
        do {
            try incorrectSound = AVAudioPlayer(contentsOfURL: alertSound)
            incorrectSound.prepareToPlay()
            incorrectSound.play()
        } catch {
            print("there is \(error)")
        }
            }
    
    func mayBeCorrect(shellnumberString: String, shellnumberInt: Int) {
    
    //sum the numbers inputted into the textboxes - these should add up to the atomic number for an atom
          let sum = textBoxInput.reduce(0, combine: +)
        if atomicnumber == sum {
    setAlertCorrect("Correct!", messageText: "Well done!")
    } else {
    let stringHint = "Wrong number of electrons in shell " + shellnumberString
        let shellnumberminus1 = shellnumberInt - 1
        setIncorrect(stringHint, shellTextBox: shellnumberminus1)
    
    }
    }
    
    func setAlertCorrect(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { action in
                        if self.playChoice == 11 && self.atomicnumber == 20 {
                self.dismissViewControllerAnimated(true, completion: nil)
                let level1easyChoicesViewController = EasyLevel1ChoicesViewController()
                self.presentViewController(level1easyChoicesViewController, animated:true, completion:nil)
            } else if self.playChoice == 13 && self.atomicnumber == 35 {
                self.dismissViewControllerAnimated(true, completion: nil)
                //let level1mediumChoicesViewController = MediumLevel1ChoicesViewController()
                self.presentViewController(MediumLevel1ChoicesViewController(), animated:true, completion:nil)
                
            } else if self.playChoice > 30 {
                self.performSegueWithIdentifier("NumberFormToPEN", sender: self)
            }  else if self.playChoice < 30 {
                self.resetForNewElement()
            }
        }
        ()
        // Present Alert Controller
        self.presentViewController(alertController, animated: true, completion: nil)
        let starsImage = UIImage(named: "stars")
        
        let imageView = UIImageView(frame: CGRectMake(10, 5, 250, 70))
        imageView.image = starsImage
        
        //alert.view.addSubview(imageView)
        alertController.view.addSubview(imageView)
        // Add Actions
        alertController.addAction(okAction)
        //set sound file name and extension
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("correctSound", ofType: "wav")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        
       // var error: NSError?
        /*
        do {
            //play sound
            correctSound = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch var error1 as NSError {
            error = error1
            correctSound = nil
        }
*/
        // Preparation
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        // Play the sound
        do {
            try correctSound = AVAudioPlayer(contentsOfURL: alertSound)
            correctSound.prepareToPlay()
            correctSound.play()
        } catch {
            print("there is \(error)")
        }
        
               //NEED SOMETHING IN HERE TO BRING UP "YOU HAVE COMPLETED THE LEVEL", WHEN THEY PRESS "OK". IF on LAST ELEMENT OF THAT LEVEL
        // NEED SOMETHING IN HERE TO BRING UP PEN SCREEN WHEN CLICK OK, IF THEY ARE DOING LEVEL 3
    }
    
    func resetForNewElement() {
    //atomic number is reset first    //generate different atomicnumber
    setAtomicnumber()
        //change element image
        self.elementIonImage.image = UIImage(named: elementImagesArray[atomicnumber])
        //make edit text boxes empty, and with black text
    clearNumberForm()
    }
    
    func setAtomicnumber() {
        if playChoice == 11 || playChoice == 31 {
            ++atomicnumber
            //'previousPressedInPENScreen' required because otherwise ShellsScreen will treat it as a 'next'.
            //When user presses previous in PEN Screen, 'previousPressedInPENScreen' changes to a 1, hence allowing
            //choices here
            
        } else if playChoice == 13 || (playChoice == 33 && fromPreviousInPENScreen == false) {
            //method to call to choose which element/ion to bring up next.  I think the atomionLabel array will
            //have to be ordered as atomthenion, or maybe not?  Maybe I will have to go through each element/ion
            //individually and specify which element/ion to bring up next, to amke it go in order.  There are
            //quite a few that will just be atomicnumber++, then just do other separately
            getNextAtomThenIon()
        }
        else if playChoice == 33 && fromPreviousInPENScreen == false {
            //  getPreviousAtomthenIon();
            //reset previousPressedInPENScreen to zero, because this has now been used for the purpose intended i.e.
            //to tell ShellsScreen that the user clicked the previous button in the PENScreen.
            fromPreviousInPENScreen = false
        } else if playChoice == 12 || playChoice == 32 {
            atomicnumber = Int(arc4random_uniform(20) + 1)
            //atomicnumber = 1 + (int) (Math.random() * ((20 - 1) + 1));
        } else if playChoice == 14 || playChoice == 34 {
            atomicnumber = Int(arc4random_uniform(15) + 21)
        } else if playChoice == 15 || playChoice == 16 || playChoice == 35 || playChoice == 36 {
            atomicnumber = Int(arc4random_uniform(35) + 1)
        }
    }
    
        func clearNumberForm(){
        shell1TextBox.text = ""
        shell2TextBox.text = ""
        shell3TextBox.text = ""
        shell4TextBox.text = ""
            
            for var i=0; i<4; i++ {
            NumberFormTextBoxes[i].textColor = UIColor.blackColor()
        }
    }
    
    func getNextAtomThenIon() {
        if atomicnumber == 0 || atomicnumber == 21 || atomicnumber == 2 || atomicnumber == 5 || atomicnumber == 6 || atomicnumber == 10 || atomicnumber == 14 || atomicnumber == 18 {
            ++atomicnumber
        } else if atomicnumber == 1 || atomicnumber == 3 || atomicnumber == 4 {
            atomicnumber = atomicnumber + 20
        } else if atomicnumber == 22 {
            atomicnumber = atomicnumber - 20
        } else if atomicnumber == 23 || atomicnumber == 24 {
            atomicnumber = atomicnumber - 19
        } else if atomicnumber == 7 || atomicnumber == 8 || atomicnumber == 9 {
            atomicnumber = atomicnumber + 18
        } else if atomicnumber == 25 || atomicnumber == 26 || atomicnumber == 27 {
            atomicnumber = atomicnumber - 17
        } else if atomicnumber == 11 || atomicnumber == 12 || atomicnumber == 13 {
            atomicnumber = atomicnumber + 17
        } else if atomicnumber == 28 || atomicnumber == 29 || atomicnumber == 30 {
            atomicnumber = atomicnumber - 16
        } else if atomicnumber == 15 || atomicnumber == 16 || atomicnumber == 17 {
            atomicnumber = atomicnumber + 16
        } else if atomicnumber == 31 || atomicnumber == 32 || atomicnumber == 33 {
            atomicnumber = atomicnumber - 15
        } else if atomicnumber == 19 || atomicnumber == 20 {
            atomicnumber = atomicnumber + 15
        } else {
            atomicnumber = atomicnumber - 14
        }
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        clearEditTexts()
    }
    
    func clearEditTexts(){
        shell1TextBox.text = ""
        shell2TextBox.text = ""
        shell3TextBox.text = ""
        shell4TextBox.text = ""
        
        for var i=0; i<4; i++ {
            NumberFormTextBoxes[i].textColor = UIColor.blackColor()
        }
    }


func setGeneralAlert(titleText: String, messageText: String) {
    // Initialize Alert Controller
    let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
    
    // Initialize Action
    let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in }
    self.presentViewController(alertController, animated: true, completion: nil)
    
    //add actions
    alertController.addAction(okAction)
}

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "NumberFormToPEN" {
            let vc = segue.destinationViewController as! PENScreenViewController
            let DestViewController : PENScreenViewController = segue.destinationViewController as! PENScreenViewController
            DestViewController.playChoice = Int(playChoice)
            DestViewController.elementSymbolNumber = Int(atomicnumber)
            vc.delegate = self
        } else if segue.identifier == "ShellsToCompletedLevel" {
            let DestViewController : LevelCompletedViewController = segue.destinationViewController as! LevelCompletedViewController
            DestViewController.playChoice = Int(playChoice)
            
        }
    }
    

}
