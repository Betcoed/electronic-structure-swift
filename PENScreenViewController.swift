//
//  PENScreenViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 25/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

protocol PENScreenViewControllerDelegate{
    func myVCDidFinish(controller:PENScreenViewController, elementNumber: Int, fromPreviousInPENScreen: Bool)
}

class PENScreenViewController: UIViewController {
    
    var delegate:PENScreenViewControllerDelegate? = nil
    
    var playChoice = Int()
    var elementSymbolNumber = 0
    var PENnumbers: [Int] = []
    var numberOfProtons: [Int] = []
    var numberOfElectrons: [Int] = []
    var numberOfNeutrons: [Int] = []
    var numberOfProtonsLevel3: [Int] = []
    var numberOfElectronsLevel3: [Int] = []
    var numberOfNeutronsLevel3: [Int] = []
    var correctSound = AVAudioPlayer()
    var incorrectSound = AVAudioPlayer()
    var PENTextBoxes: [UITextField] = []
    var previousPressedInPENScreen = false
    
    @IBOutlet weak var elementIonImage: UIImageView!
    @IBOutlet weak var protonTextBox: UITextField!
    @IBOutlet weak var electronTextBox: UITextField!
    @IBOutlet weak var neutronTextBox: UITextField!
    @IBOutlet weak var calculatorView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var previousButton: UIButton!
    
    //for calculator
    @IBOutlet weak var calculatorTextView: UITextField!
    var result = Int()
    var currentNumber = Int()
    var currentOp = String()
    
    var elementImagesArray:[String] = ["hydrogen","hydrogen_pos","Hydrogen_neg","deuterium","tritium","helium","lithium","Lithium_pos","Lithium_6_isotope","beryllium","Beryllium_pos","Boron_10_Isotope","boron","carbon","Carbon_13_isotope","Carbon_14_isotope","nitrogen","nitrogen_neg","Nitrogen_15_isotope","oxygen","oxygen_neg","Oxygen_17_isotope","Oxygen_18_isotope","fluorine","fluorine_neg","neon","Neon_21_isotope","Neon_22_isotope","sodium","sodium_pos","magnesium","magnesium_pos","Magnesium_25_isotope","Magnesium_26_isotope","aluminium","aluminium_pos","silicon","Silicon_29_isotope","Silicon_30_isotope","phosphorus","phosphorus_neg","sulphur","sulphur_neg","Sulphur_33_isotope","Sulphur_34_isotope","Sulphur_36_isotope","Chlorine35","Chlorine35anion","Chlorine37isotope","Chlorine37anion_isotope","argon","Argon36isotope","Argon38isotope","potassium","potassium_pos","Potassium40isotope","Potassium41isotope","calcium","calcium_pos","Calcium42isotope","Calcium44isotope",
        "scandium","scandium_cation","titanium46isotope","titanium47isotope","titanium48isotope","titanium48cation","vanadium50isotope","vanadium51isotope","vanadium_5plus","vanadium_4plus","vanadium_3plus","vanadium_2plus","chromium52isotope","chromium50isotope","chromium53isotope","chromium_3plus","chromium_6plus","manganese","manganese_2plus","manganese_3plus","manganese_4plus","iron54isotope","iron56isotope","iron57isotope","iron_2plus","iron_3plus","cobalt","cobalt_2plus","cobalt_3plus","nickel58isotope","nickel60isotope","nickel62isotope","nickel_2plus","copper63isotope","copper65isotope","copper_2plus","copper_cation","zinc64isotope","zinc66isotope","zinc68isotope","zinc_2plus","rhodium","rhodium_3plus","palladium105isotope","palladium106isotope","palladium108isotope","palladium_1plus","palladium_2plus","palladium_4plus","silver107isotope","silver107_1plus","silver109isotope","silver109_2plus","cadmium111isotope","cadmium112isotope","cadmium114isotope","cadmium_2plus","platinum194isotope","platinum195isotope","platinum196isotope","platinum_2plus","platinum_4plus","gold","mercury199isotope","mercury201isotope","mercury202isotope","mercury_1plus","mercury_2plus","tungsten184isotope","tungsten186isotope","tungsten182isotope",
        "arsenic","bromine79isotope","bromine81isotope","bromine79_1minus","bromine81_1minus","indium113isotope","indium115isotope","tin120isotope","tin118isotope","tin116isotope","iodine","iodine_minus","lead208isotope","lead206isotope","lead207isotope","lead_2plus","lead_4plus","krypton84isotope","krypton86isotope","krypton83isotope","xenon129isotope","xenon132isotope","xenon131isotope","caesium","caesium_cation","rubidium85isotope","rubidium87isotope","rubidium_cation","barium138isotope","barium136isotope","barium137isotope","barium_cation","uranium238isotope","uranium235isotope","plutonium"]
    
    var elementSymbolsForLevel3:[String] = [
        "hydrogen","hydrogen","helium","lithium","beryllium","boron","carbon","nitrogen","oxygen","fluorine","neon","sodium","magnesium","aluminium","silicon","phosphorus","sulphur","Chlorine35","argon","potassium","calcium","hydrogen_pos","Hydrogen_neg","Lithium_pos","Beryllium_pos","nitrogen_neg","oxygen_neg","fluorine_neg","sodium_pos","magnesium_pos","aluminium_pos","phosphorus_neg","sulphur_neg","Chlorine35anion","potassium_pos","calcium_pos"]
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtonClicked"), animated: true)
            
            switch playChoice {
            case 24,32,34,35,36:
                self.previousButton.hidden = true
            default:
                self.previousButton.hidden = false
            }
            
            numberOfProtons = [
                1,1,1,1,1,2,3,3,3,4,4,5,5,6,6,6,7,7,7,8,8,8,8,9,9,10,10,10,11,11,12,12,12,12,13,13,
                14,14,14,15,15,16,16,16,16,16,17,17,17,17,18,18,18,19,19,19,19,20,20,20,20,21,21,
                22,22,22,22,23,23,23,23,23,23,24,24,24,24,24,25,25,25,25,26,26,26,26,26,27,27,27,
                28,28,28,28,29,29,29,29,30,30,30,30,45,45,46,46,46,46,46,46,47,47,47,47,48,48,48,48,
                78,78,78,78,78,79,80,80,80,80,80,74,74,74,33,35,35,35,35,49,49,50,50,50,
                53,53,82,82,82,82,82,36,36,36,54,54,54,55,55,37,37,37,56,56,56,56,92,92,94
            ]
            numberOfElectrons = [
                1,0,2,1,1,2,3,2,3,4,2,5,5,6,6,6,7,10,7,8,10,8,8,9,10,10,10,10,11,10,12,10,12,12,13,10,
                14,14,14,15,18,16,18,16,16,16,17,18,17,18,18,18,18,19,18,19,19,20,18,20,20,21,18,
                22,22,22,18,23,23,18,19,20,21,24,24,24,21,18,25,23,22,21,26,26,26,24,23,27,25,24,
                28,28,28,26,29,29,27,28,30,30,30,28,45,42,46,46,46,45,44,42,47,46,47,45,48,48,48,46,
                78,78,78,76,74,79,80,80,80,79,78,74,74,74,33,35,35,36,36,49,49,50,50,50,
                53,54,82,82,82,80,78,36,36,36,54,54,54,55,54,37,37,36,56,56,56,54,92,92,94
            ]
            numberOfNeutrons = [
                0,0,0,1,2,2,4,4,3,5,5,5,6,6,7,8,7,7,8,8,8,9,10,10,10,10,11,12,12,12,12,12,13,14,14,14,
                14,15,16,16,16,16,16,17,18,20,18,18,20,20,22,18,20,20,20,21,22,20,20,22,24,24,24,
                24,25,26,26,27,28,28,28,28,28,28,26,29,28,28,30,30,30,30,28,30,31,30,30,32,32,32,
                30,32,34,30,34,36,34,34,34,36,38,34,58,58,59,60,62,60,60,60,60,60,62,62,63,64,66,66,
                116,117,118,117,117,118,119,121,122,122,122,110,112,108,42,44,46,44,46,64,66,70,68,66,
                74,74,126,124,125,126,126,48,50,47,75,78,77,78,78,48,50,50,82,80,81,81,146,143,145
            ]
            
            //an extra 0 has been put in at position '0', because in ShellsScreen, the numbering starts at 1, not 0
            numberOfProtonsLevel3 = [
                0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,1,1,3,4,7,8,9,11,12,13,15,16,17,19,20
            ]
            
            //an extra 0 has been put in at position '0', because in ShellsScreen, the numbering starts at 1, not 0
            numberOfElectronsLevel3 = [
                0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,0,2,2,2,10,10,10,10,10,10,18,18,18,18,18
            ]
            
            //an extra 0 has been put in at position '0', because in ShellsScreen, the numbering starts at 1, not 0
            numberOfNeutronsLevel3 = [
                0,0,2,4,5,6,6,7,8,10,10,12,12,14,14,16,16,18,22,20,20,0,0,4,5,7,8,10,12,12,14,16,16,18,20,20
            ]
            
            PENTextBoxes = [protonTextBox, electronTextBox, neutronTextBox]

            PENnumbers = [0,0,0]
        // Do any additional setup after loading the view.
        switch playChoice {
        case 21:
            elementSymbolNumber = 0
            break
        case 22:
            elementSymbolNumber = 61
            break
        case 23:
            elementSymbolNumber = 132
            break
        case 24:
            elementSymbolNumber = Int(arc4random_uniform(167))
        default:
           break
        }
        //change element image
            if playChoice < 30 {
        self.elementIonImage.image = UIImage(named: elementImagesArray[elementSymbolNumber])
            } else {
                self.elementIonImage.image = UIImage(named: elementSymbolsForLevel3[elementSymbolNumber])
            }
            for var i=0; i<3; i++ {
              //PENTextBoxes[2].delegate = self
                
               // PENTextBoxes[i].keyboardType = UIKeyboardType.NumberPad
               // textFieldShouldReturn(PENTextBoxes[i])
                
            }
                }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
        navigationController!.popViewControllerAnimated(true)
    }
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
            PENTextBoxes[2].resignFirstResponder()
        calculatorView.resignFirstResponder()
        
       // }
        return true
    }
    
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func checkButton(sender: AnyObject) {
        //set empty text boxes to zero, and change anything written in the textboxes to numbers, to avoid confusion with
        //how the user has entered numbers
       // setEmptyTextViewsToZero()
        retrieveNumbers()
        //if level 3 (so user is completing elec structures AND PEN, then use different checking method,
        //since answers are held in different arrays
        
        if (playChoice < 30) {
            checkForLevel2()
        }
            //
        else {
             checkForLevel3()
        }
        //
    }
    
    func checkForLevel2() {
    if (PENnumbers[0] == numberOfProtons[elementSymbolNumber]) {
    //if protons correct, then check electrons
    if (PENnumbers[1] == numberOfElectrons[elementSymbolNumber]) {
    
    //if electrons and protons correct, then check neutrons
    if (PENnumbers[2] == numberOfNeutrons[elementSymbolNumber]) {
    
    setCorrect()
    } else {
    //if neutrons wrong, then show incorrect message
    setIncorrect("Wrong number of neutrons", PEN: 2)
    }
    } else {
    //if number of electrons wrong then show incorrect message
    setIncorrect("Wrong number of electrons", PEN: 1)
    }
    } else {
    //if number of protons wrong then show incorrect message
    setIncorrect("Wrong number of protons", PEN: 0)
    }
    }
 
    
    func checkForLevel3() {
    if (PENnumbers[0] == numberOfProtonsLevel3[elementSymbolNumber]) {
    //if protons correct, then check electrons
    if (PENnumbers[1] == numberOfElectronsLevel3[elementSymbolNumber]) {
    
    //if electrons and protons correct, then check neutrons
    if (PENnumbers[2] == numberOfNeutronsLevel3[elementSymbolNumber]) {
    
        setCorrect()
    } else {
        //if neutrons wrong, then show incorrect message
        setIncorrect("Wrong number of neutrons", PEN: 2)
        }
    } else {
        //if number of electrons wrong then show incorrect message
        setIncorrect("Wrong number of electrons", PEN: 1)
        }
    } else {
        //if number of protons wrong then show incorrect message
        setIncorrect("Wrong number of protons", PEN: 0);
        }
    }
    
    @IBAction func onClickClearPEN(sender: AnyObject) {
       clearEditTexts()
    }
    
    
    //tells the user they are correct, then moves on to the next element/ion
    func setCorrect() {
        //bring up correct alert, and change element, if playChoice is between 20-30
        setAlertCorrect("Correct!", messageText: "Well Done!")
        if (playChoice > 30) {
                    //change to next element
            }
    }
    
    func setIncorrect(hint: String, PEN: Int) {
    //set colour of wrong number to red
    PENTextBoxes[PEN].textColor = UIColor.redColor()
        //bring up alert to say incorrect, with reason
        setAlertIncorrect("Incorrect", messageText: hint)
    }
    
    func retrieveNumbers() {
        
        for var i=0; i<3; i++ {
        if PENTextBoxes[i].text!.isEmpty {
            PENTextBoxes[i].text = "0"
        }
          
        }
        let protonTextFieldasNumber : Int? = Int(protonTextBox.text!)
        let electronTextFieldasNumber : Int? = Int(electronTextBox.text!)
        let neutronTextFieldasNumber : Int? = Int(neutronTextBox.text!)
        
        if  (protonTextFieldasNumber == nil || electronTextFieldasNumber == nil || neutronTextFieldasNumber == nil) {
            setGeneralAlert("Warning", messageText: "Each text box must contain a number")
        } else {
            PENnumbers[0] = protonTextFieldasNumber!
            PENnumbers[1] = electronTextFieldasNumber!
            PENnumbers[2] = neutronTextFieldasNumber!
        }
    }
    
    @IBAction func onClickPreviousPEN(sender: AnyObject) {
         previousPressedInPENScreen = true
        if elementSymbolNumber == 0 || ((playChoice == 31 || playChoice == 33) && elementSymbolNumber == 1) {
            //SETALERT
            setGeneralAlert("Warning", messageText: "No smaller elements.  Click NEXT for larger elements")
        } else if playChoice > 30 {
            if playChoice == 31 {
                elementSymbolNumber = elementSymbolNumber - 2
                self.elementIonImage.image = UIImage(named: elementSymbolsForLevel3[elementSymbolNumber])
            }
            //go back to shells screen - send through "previousPressedInPENScreen", and elementSymbolNumber, and playChoice number
                        if (self.delegate != nil) {
                self.delegate!.myVCDidFinish(self, elementNumber: self.elementSymbolNumber, fromPreviousInPENScreen: self.previousPressedInPENScreen)
               
            }
        }
            else if (playChoice == 22 && elementSymbolNumber == 61 || (playChoice == 23 && elementSymbolNumber == 132)) {
                //SET ALERT
            setGeneralAlert("No smaller elements", messageText: "Click NEXT for larger elements.  Go to easier level for smaller elements")
        } else {
                    --elementSymbolNumber
            self.elementIonImage.image = UIImage(named: elementImagesArray[elementSymbolNumber])
        }
        clearEditTexts()
       // self.elementIonImage.image = UIImage(named: elementImagesArray[elementSymbolNumber])
    }
    
           @IBAction func onClickNextPEN(sender: AnyObject) {
        let elementStartValueTuple = (elementSymbolNumber, playChoice)
        switch elementStartValueTuple {
        case(20,31),(35,33),(60,21),(131,22),(166,23):
            setGeneralAlert("Warning", messageText: "No more elements available for this level")
        case(0...35,31...36):
            if (self.delegate != nil) {
                self.delegate!.myVCDidFinish(self, elementNumber: self.elementSymbolNumber, fromPreviousInPENScreen: self.previousPressedInPENScreen)
            }
        default:
       nextElementIonIsotope()
       clearEditTexts()
            break
        }
            }
    
    
    @IBAction func onClickCalculator(sender: UIButton) {
        self.buttonsView.hidden = true
        self.calculatorView.hidden = false
        currentOp = "="
        calculatorTextView.text = ("\(result)")
    }
    
    @IBAction func btnNumberInput(sender: UIButton) {
        currentNumber = currentNumber * 10 + Int(sender.titleLabel!.text!)!
        calculatorTextView.text = ("\(currentNumber)")
        
    }

    @IBAction func btnOperation(sender: UIButton) {
        
        switch currentOp {
        case "=":
            result = currentNumber
            case "+":
                
                result = result + currentNumber
           // calculatorTextView.text = ("\(result)") + "+"
        case "-":
             //   calculatorTextView.text = ("\(result)" + "-")
                result = result - currentNumber
        default:
            print("error")
            }
        currentNumber = 0
        calculatorTextView.text = ("\(result)")
        if(sender.titleLabel!.text == "=") {
            result = 0
        }
        currentOp = sender.titleLabel!.text! as String!
    }
    
    @IBAction func btnCalculatorClear(sender: UIButton) {
        result = 0
        currentNumber = 0
        currentOp = "="
        calculatorTextView.text = ("\(result)")
        
    }
    
    @IBAction func btnDismiss(sender: UIButton) {
        self.buttonsView.hidden = false
        self.calculatorView.hidden = true
    }
    
    
func nextElementIonIsotope() {
    switch (playChoice) {
    case 24:
        elementSymbolNumber = Int(arc4random_uniform(167))
    default:
        ++elementSymbolNumber
    }
    
    self.elementIonImage.image = UIImage(named: elementImagesArray[elementSymbolNumber])
    }
    
    func clearEditTexts(){
        protonTextBox.text = ""
        electronTextBox.text = ""
        neutronTextBox.text = ""
        
        for var i=0; i<3; i++ {
            PENTextBoxes[i].textColor = UIColor.blackColor()
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
    
    func setAlertCorrect(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            if (self.playChoice == 21 && self.elementSymbolNumber == 60) || (self.playChoice == 13 && self.elementSymbolNumber == 131) || (self.playChoice == 23 && self.elementSymbolNumber == 166) || (self.playChoice == 31 && self.elementSymbolNumber == 20) || (self.playChoice == 22 && self.elementSymbolNumber == 131) || (self.playChoice == 33 && self.elementSymbolNumber == 35) {
                
                self .performSegueWithIdentifier("PENToCompletedLevel", sender: self)
              //  [self .performSegueWithIdentifier("PENToCompletedLevel", sender: sender)]
            }
            else if self.playChoice > 30 {
                if (self.delegate != nil) {
                    self.delegate!.myVCDidFinish(self, elementNumber: self.elementSymbolNumber, fromPreviousInPENScreen: self.previousPressedInPENScreen)
                }
            } else if self.playChoice < 30 {
                self.nextElementIonIsotope()
                self.clearEditTexts()
            }
        }
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
                  }
    
    func setAlertIncorrect(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            
        }
        //change height of alert controller
       // let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
        
        //alertController.view.addConstraint(height);
        
        // Present Alert Controller
        self.presentViewController(alertController, animated: true, completion: nil)
       // let sadfaceImage = UIImage(named: "sadface")
        
        //let imageView = UIImageView(frame: CGRectMake(100, 70, 70, 70))
        //imageView.image = sadfaceImage
        
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
    
    func setAlertLevelCompleted(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            
        }
        //change height of alert controller
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
        
        alertController.view.addConstraint(height);
        
        // Present Alert Controller
        self.presentViewController(alertController, animated: true, completion: nil)
        let bigstarImage = UIImage(named: "bigstar")
        
        let imageView = UIImageView(frame: CGRectMake(100, 70, 70, 70))
        imageView.image = bigstarImage
        
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
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PENToCompletedLevel" {
            let DestViewController : LevelCompletedViewController = segue.destinationViewController as! LevelCompletedViewController
            DestViewController.playChoice = Int(playChoice)
            
        }
    }
    

}
