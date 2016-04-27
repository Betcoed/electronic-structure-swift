//
//  ShellsViewController.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 15/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

//let shellsizesArray: [CGFloat] = [88, 176, 264, 352]
var radiusOfShells: [CGFloat] = []
var radiusSquared: [CGFloat] = []
var locationOfTouch = CGPoint(x: 0, y: 0)
var touchcanvasnumber = 0
var Zoriginaldistfromcentre: CGFloat = 0.0
var shellBoundaries: [[CGFloat]] = []
var elecposXArray: [CGFloat] = []
var elecposYArray: [CGFloat] = []
var ZvalueElectronPosition: [CGFloat] = []

protocol FirstScreenViewControllerDelegate {
    func myVCShellsFromPlayDidFinish(controller:ShellsViewController, firstTimeFromShells: Bool)
}

class ShellsViewController: UIViewController, PENScreenViewControllerDelegate {
    
    var delegate: FirstScreenViewControllerDelegate? = nil
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var cyanball1: UIImageView!
    @IBOutlet weak var cyanball2: UIImageView!
    @IBOutlet weak var cyanball3: UIImageView!
    @IBOutlet weak var cyanball4: UIImageView!
    @IBOutlet weak var cyanball5: UIImageView!
    @IBOutlet weak var cyanball6: UIImageView!
    @IBOutlet weak var cyanball7: UIImageView!
    @IBOutlet weak var cyanball8: UIImageView!
    @IBOutlet weak var cyanball9: UIImageView!
    @IBOutlet weak var cyanball10: UIImageView!
    @IBOutlet weak var cyanball11: UIImageView!
    @IBOutlet weak var cyanball12: UIImageView!
    @IBOutlet weak var cyanball13: UIImageView!
    @IBOutlet weak var cyanball14: UIImageView!
    @IBOutlet weak var cyanball15: UIImageView!
    @IBOutlet weak var cyanball16: UIImageView!
    @IBOutlet weak var cyanball17: UIImageView!
    @IBOutlet weak var cyanball18: UIImageView!
    @IBOutlet weak var cyanball19: UIImageView!
    @IBOutlet weak var cyanball20: UIImageView!
    
    @IBOutlet weak var concirclesUIView: ConcirclesView!
    
    
    
    var elementImagesArray:[String] = ["hydrogen","hydrogen","helium","lithium","beryllium","boron","carbon","nitrogen","oxygen","fluorine","neon","sodium","magnesium","aluminium","silicon","phosphorus","sulphur","chlorine","argon","potassium","calcium","hydrogen_pos","Hydrogen_neg","Lithium_pos","Beryllium_pos","nitrogen_neg","oxygen_neg","fluorine_neg","sodium_pos","magnesium_pos","aluminium_pos","phosphorus_neg","sulphur_neg","chlorine_neg","potassium_pos","calcium_pos"]
    
    //create array of electron UIImageimages
    var electronsArray: [UIImageView] = []
    
    
    var playChoice = Int()
    var firstTimeShells = Bool()
    
    
    var atomicnumber = 0
        var radiusSquared: [CGFloat] = []
    var isElectronTooClose = false
    var NumberElectronsInEachShell: [Int] = []
    
    
    var clickSound = AVAudioPlayer()
    var correctSound = AVAudioPlayer()
    var incorrectSound = AVAudioPlayer()
    var correct = false
    
    var fromBackInPENScreen = false
    var oldatomicnumber = 1
    
    func myVCDidFinish(controller: PENScreenViewController, elementNumber: Int, fromPreviousInPENScreen: Bool) {
        
        atomicnumber = elementNumber
        fromBackInPENScreen = fromPreviousInPENScreen
        controller.navigationController?.popViewControllerAnimated(true)
        //resetElectronsToZero()
        setAtomicnumber()
        reset()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func shouldAutorotate() -> Bool {
        if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.Unknown) {
                return false;
        }
        else {
            return true;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   #if Core
      //      let coreVersion = "true"
       //     #endif
        
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtonClicked"), animated: true)
        // Do any additional setup after loading the view.
        
        //alert comes up with instructions on what to do
        setGeneralAlert("Instructions", messageText: "The white circles are energy levels. Touch the screen where you want an electron to appear.")
                //setup electronArray (array of images, each containing an image of electrons)
        electronsArray = [cyanball1, cyanball2, cyanball3, cyanball4, cyanball5, cyanball6, cyanball7, cyanball8, cyanball9, cyanball10, cyanball11, cyanball12, cyanball13, cyanball14, cyanball15, cyanball16, cyanball17, cyanball18, cyanball19, cyanball20]

        
        NumberElectronsInEachShell = [0,0,0,0]
               setAtomicnumber()
        reset()
        
    }
              
    func doneButtonClicked() {
        if firstTimeShells == false {
        self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            firstTimeShells = false
            if (self.delegate != nil) {
                self.delegate!.myVCShellsFromPlayDidFinish(self, firstTimeFromShells: firstTimeShells)
            }
          //  [self .performSegueWithIdentifier("shellsToFirstScreenSegue", sender: self)]
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func deduceShellBoundaries() {
        let percentOfRadius0 = 0.45 * radiusOfShells[0]
      let shell1lowerBoundary = radiusOfShells[0] - percentOfRadius0
        let shell1upperBoudary = radiusOfShells[0] + percentOfRadius0
        let shell2lowerBoundary = radiusOfShells[1] - percentOfRadius0
        let shell2upperBoudary = radiusOfShells[1] + percentOfRadius0
        let shell3lowerBoundary = radiusOfShells[2] - percentOfRadius0
        let shell3upperBoudary = radiusOfShells[2] + percentOfRadius0
        let shell4lowerBoundary = radiusOfShells[3] - percentOfRadius0
        let shell4upperBoudary = radiusOfShells[3] + percentOfRadius0
        
        shellBoundaries = [[shell1lowerBoundary, shell1upperBoudary],[shell2lowerBoundary, shell2upperBoudary],[shell3lowerBoundary,shell3upperBoudary],[shell4lowerBoundary,shell4upperBoudary]]
                     }
    
    
    func deduceRadiusSquared() {
        
                let radiusShell1Squared = radiusOfShells[0] * radiusOfShells[0]
        let radiusShell2Squared = radiusOfShells[1] * radiusOfShells[1]
        let radiusShell3Squared = radiusOfShells[2] * radiusOfShells[2]
        let radiusShell4Squared = radiusOfShells[3] * radiusOfShells[3]
      //  radiusOfShells = [radiusOfShell1, radiusOfShell2, radiusOfShell3, radiusOfShell4]
        radiusSquared = [radiusShell1Squared, radiusShell2Squared, radiusShell3Squared, radiusShell4Squared]

    }
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
                let touch = touches.first
        //let touch : UITouch! = touches.anyObject() as! UITouch
        
        deduceShellBoundaries()
        deduceRadiusSquared()
        locationOfTouch = (touch?.locationInView(concirclesUIView))!
        
        //get distance of touch from centre of UIView, using pythagorus
        electronDistFromCentre()
        
       // if electronsArray[0].frame.origin == CGPoint(x: 0, y: 0) {
            if electronsArray[0].hidden == true {
            //check which shell the electron has been placed nearest to.  This method also then "snaps" the electron
            //to the nearest shell line, making the look of it neater
            //the electron is then made visible
            nearestToWhichShell()
            
                    } else {
            if touchcanvasnumber == 20 {
                //alert pops up to tell user there are no more electrons
                setGeneralAlert("No more electrons", messageText: "No more electrons available")
            } else {
            for var i=0; i<20; i++ {
            
           // if electronsArray[i].frame.origin != CGPoint(x: 0, y: 0) &&  electronsArray[i+1].frame.origin == CGPoint(x: 0, y: 0){
                if electronsArray[i].hidden == false && electronsArray[i+1].hidden == true {
                //get electrons distance from centre of UIView, using pythagorus
                //check which shell the electron has been placed nearest to.  This method also then "snaps" the electron
                //to the nearest shell line, making the look of it neater
                //the electron is then made visible
                nearestToWhichShell()
                                        break
                }
            }
            }
            
        }
                   }
    
    //find distance between center and where user has touched (i.e. where user wants to put electron)
    func electronDistFromCentre() {
        
        let center = concirclesUIView.center
        // "concirclesUIView.frame.origin.x" and "concirclesUIView.frame.origin.y" have been added because "center" is in coordinates of the whole screen, whereas locationOfTouch is in the center
        //of the UIView.  Feels like a fudge but can't think of a more elegant way to get it to work.
        let xDist = (center.x - concirclesUIView.frame.origin.x) - locationOfTouch.x
        let yDist = (center.y - concirclesUIView.frame.origin.y) - locationOfTouch.y
        Zoriginaldistfromcentre = sqrt((xDist * xDist) + (yDist * yDist))
       
    }
   
    func nearestToWhichShell() {
        
        if Zoriginaldistfromcentre > shellBoundaries[0][0] && Zoriginaldistfromcentre < shellBoundaries[0][1] {
            //call method to reset electron to position so it snaps to the shell1
            resetElectronPosition(radiusSquared[0])
        } else if Zoriginaldistfromcentre > shellBoundaries[1][0] && Zoriginaldistfromcentre < shellBoundaries[1][1] {
            resetElectronPosition(radiusSquared[1])
        } else if Zoriginaldistfromcentre > shellBoundaries[2][0] && Zoriginaldistfromcentre < shellBoundaries[2][1] {
            resetElectronPosition(radiusSquared[2])
        } else if Zoriginaldistfromcentre > shellBoundaries[3][0] && Zoriginaldistfromcentre < shellBoundaries[3][1] {
            resetElectronPosition(radiusSquared[3])
        } else {
            //where a method is called which makes a toast appear and tell the user to touch on the white line of a shell
           // setToast("Touch on the white line of a shell");
        }
    }
    
    func resetElectronPosition(shellZsquared: CGFloat) {
        //this method will also check whether a user has tried to place one electron on top of another.
        //It can  cause a bug if they do this, because they may think they've put less electrons in than they really have.
        
        isElectronTooClose = false;
        //check if the electron has been placed in an area between 10 O'clock to 2 O'Clock on the canvas,
        //or between 4 O'clock and 8 O'Clock
        
            if locationOfTouch.x >= (concirclesUIView.bounds.width * 0.34860) && locationOfTouch.x <= (concirclesUIView.bounds.width * 0.655835) {
                //if yes then reset the y value
            let temp = abs(shellZsquared - ((locationOfTouch.x - concirclesUIView.bounds.width / 2) * (locationOfTouch.x - concirclesUIView.bounds.width / 2)))
            //I've put the following if statement in because at one point I was trying to sqrt a negative when the user
            //pressed in certain parts of the screen.  However, being careful to set the upper and lower values of x for
            //the above if statement, and making the previous line an absolute value, seems to have sorted the
            //problem out, but I've left the if statement below in just in case.
            if temp < 0 {
                setGeneralAlert("No electron placed", messageText: "An electron has not been placed.  Try again")
                            } else {
                if locationOfTouch.y < concirclesUIView.bounds.height / 2 {
                    locationOfTouch.y = abs(sqrt(temp) - concirclesUIView.bounds.width / 2)
                } else {
                    locationOfTouch.y = sqrt(temp) + concirclesUIView.bounds.width / 2
                }
            }
            locationOfTouch.y = locationOfTouch.y - electronsArray[0].bounds.height / 2
            locationOfTouch.x = locationOfTouch.x - electronsArray[0].bounds.width / 2
            locationOfTouch = CGPointMake(locationOfTouch.x, locationOfTouch.y)
            
            //call method to check whether the user is trying to put an electron too close to another one already there
            electronTooClose(locationOfTouch.x, ypos: locationOfTouch.y);
            
            //now that the x and y values have been reset so the electrons snaps to the nearest shell line,
            // make the electron visible
            if !isElectronTooClose {
                
                makeElectronVisible(shellZsquared)
            }
            
            
        } else {
            //if no then reset the x value
            let temp2 = abs(shellZsquared - ((locationOfTouch.y - concirclesUIView.bounds.height / 2) * (locationOfTouch.y - concirclesUIView.bounds.height / 2)))
            //see above for why this if statement is here
            if (temp2 < 0) {
                setGeneralAlert("No electron placed", messageText: "An electron has not been placed.  Try again")
            } else {
                if (locationOfTouch.x < concirclesUIView.bounds.width / 2) {
                    
                    locationOfTouch.x = abs(sqrt(temp2) - concirclesUIView.frame.height / 2)
                } else {
                    locationOfTouch.x = sqrt(temp2) +
                        concirclesUIView.bounds.height / 2
                }
            }
            
            locationOfTouch.y = locationOfTouch.y - electronsArray[0].bounds.width / 2
            locationOfTouch.x = locationOfTouch.x - electronsArray[0].bounds.width / 2
            locationOfTouch = CGPointMake(locationOfTouch.x, locationOfTouch.y)
            
            //check whether or not the new electron has been placed too close to an old electron
            electronTooClose(locationOfTouch.x, ypos: locationOfTouch.y);
                        //make electron visible, BUT ONLY IF ELECTRONS TRYING TO BE ADDED IS NOT TOO CLOSE - SO NEEDS TO BE
            //IN AN IF STATEMENT
            
            if !isElectronTooClose {
                
                makeElectronVisible(shellZsquared)
            }

        }
    }
    
    //checks whether user is trying to place an electron too close to one already there.
    func electronTooClose(xpos: CGFloat, ypos: CGFloat) {
        for var i = 0; i < elecposYArray.count; i++ {
            if ypos > (elecposYArray[i] - 10) && ypos < (elecposYArray[i] + 10) && xpos > (elecposXArray[i] - 10) && (xpos < elecposXArray[i] + 10) {
                isElectronTooClose = true
                setGeneralAlert("Electrons too close", messageText: "Attempt to place an electron too close to another one.  Try again")
            }
        }
    }

    func makeElectronVisible(Zsquared: CGFloat) {
        
      // drawElectron()
        electronsArray[touchcanvasnumber].frame.origin = locationOfTouch
        electronsArray[touchcanvasnumber].hidden = false
        
        elecposXArray[touchcanvasnumber] = locationOfTouch.x
        elecposYArray[touchcanvasnumber] = locationOfTouch.y
        ZvalueElectronPosition[touchcanvasnumber] = sqrt(Zsquared)
               ++touchcanvasnumber
        //set sound file name and extension
                let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click1", ofType: "wav")!)
        
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
            try clickSound = AVAudioPlayer(contentsOfURL: alertSound)
            clickSound.prepareToPlay()
            clickSound.play()
        } catch {
            print("there is \(error)")
        }
        
    }

    
    func drawElectron() {
    // Set the Center of the Circle
    // 1
    let circleCenter = locationOfTouch
    
    // Set a random Circle Radius
    // 2
    let circleWidth = CGFloat(40.0)
    let circleHeight = circleWidth
    
    // Create a new CircleView
    // 3
    let circleView = drawElectronsView(frame: CGRectMake(circleCenter.x, circleCenter.y, circleWidth, circleHeight))
    view.addSubview(circleView)
    }
    
        func countElectronsinEachShell() {
    for var i = 0; i < ZvalueElectronPosition.count; i++ {
    if round(ZvalueElectronPosition[i]) == round(radiusOfShells[0]) {
    NumberElectronsInEachShell[0]++
    } else if round(ZvalueElectronPosition[i]) == round(radiusOfShells[1]) {
    NumberElectronsInEachShell[1]++
    } else if round(ZvalueElectronPosition[i]) == round(radiusOfShells[2]) {
    NumberElectronsInEachShell[2]++
    } else if round(ZvalueElectronPosition[i]) == round(radiusOfShells[3]) {
    NumberElectronsInEachShell[3]++
    }
    }
    
    }
    
    
    @IBAction func checkButton(sender: AnyObject) {
        checkButtonCode()
            }
    
    
    func checkButtonCode() {
        NumberElectronsInEachShell = [0,0,0,0]
        countElectronsinEachShell()
        //set number of electrons in each shell to zero
        correct = false
        
                if atomicnumber < 21 {
            
            //call method to check electron positions against the element shown in the centre
            checkAtoms()
        } else {
            //or call method to check electron positions against ion shown in the centre
            checkIons()
        }
    }
    
    
    func checkAtoms() {
        //first check that the length of array Zvalueelectronposition is equal to the atomic number, if not, it's incorrect
        if touchcanvasnumber == atomicnumber {
            //open another if statement to start checking each separate element
            // first check that they've put electrons in shell 1, if not, the answer must be wrong (for atoms)
            
            if NumberElectronsInEachShell[0] == 0 {
                
                //   final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                //  textViewToChange.setText("Electrons required in shell 1");
                //setIncorrect();
                setAlertIncorrect("Incorrect", messageText: "Electrons required in shell 1")
                //check that there are 2 electrons in shell 1 (apart from hydrogen)
            } else if NumberElectronsInEachShell[0] == 1 && atomicnumber != 1 {
                
                setAlertIncorrect("Incorrect", messageText: "2 electrons required in shell 1")
                //check whether there are any electrons in shell 4
            } else if NumberElectronsInEachShell[3] == 0 {
                //check whether there are any electrons in shell 3
                if NumberElectronsInEachShell[2] == 0 {
                    //check whether there are any electrons in shell 2
                    if NumberElectronsInEachShell[1] == 0 {
                        //if there are no electrons ins shell 2, then call the checkanswer method, with
                        //parameters to check whether the element is hydrogen or helium, and to check whether
                        //it's correct
                        level1and2CheckAnswer(1, upperElimit: 2, shell: 0, EinPreviousShells: 0);
                    } else if NumberElectronsInEachShell[0] == 2 {
                        level1and2CheckAnswer(3, upperElimit: 10, shell: 1, EinPreviousShells: 2);
                    } else {
                        setAlertIncorrect("Incorrect", messageText: "2 electrons required in shell 1")
                    }
                } else if NumberElectronsInEachShell[0] == 1 {
                    setAlertIncorrect("Incorrect", messageText: "2 electrons required in shell 1")
                } else if NumberElectronsInEachShell[1] == 8 {
                    level1and2CheckAnswer(11, upperElimit: 18, shell: 2, EinPreviousShells: 10)
                } else {
                    setAlertIncorrect("Incorrect", messageText: "Wrong number of electrons in shell 2")
                }
                //check that there are 8 electrons in shells 2 and 3
            } else if NumberElectronsInEachShell[2] == 8 && NumberElectronsInEachShell[1] == 8 {
                //check there are 2 electrons in shell 1
                if NumberElectronsInEachShell[0] == 2 {
                    //if there are 2 electrons in shell 1 and 8 electrons in shells 2 and 3, then check whether it is
                    //calcium or potassium, and whether it is correct.
                    level1and2CheckAnswer(19, upperElimit: 20, shell: 3, EinPreviousShells: 18)
                } else {
                    setAlertIncorrect("Incorrect", messageText: "2 electrons required in shell 1")
                }
                //if not 8 electrons in shells 2 and 3, then call incorrect (by this stage the element should be
                //either potassium or calcium
            } else {
                setAlertIncorrect("Incorrect", messageText: "Incorrect number of electrons in shells 2 or 3")
            }
            
        } else {
            setAlertIncorrect("Incorrect", messageText: "Wrong number of electrons")
        }
    }
    
    //method check the answer for an ion
    //for ions the "atomicnumber" here is not their real atomicnumber, I have just numbered the ions from 21 -35
    //with H+ being 21 and Ca2+ being 35.  it is convenient to just extend the "atomicnumber" variable here.
    func checkIons() {
        if NumberElectronsInEachShell[3] != 0 {
            //final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
            // textViewToChange.setText("This ion has no electrons in shell 4");
            //setIncorrect();
            setAlertIncorrect("Incorrect", messageText: "This ion has no electrons in shell 4")
            //if condition is referring to H+
        } else if atomicnumber == 21 {
            //if there has been no touches onto the canvas (i.e. no electrons added)
            if touchcanvasnumber == 0 {
               // setCorrect();
                setAlertCorrect("Correct!", messageText: "Well Done!")
            } else {
                //final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                // textViewToChange.setText("This ion has no electrons");
                //setIncorrect();
                setAlertIncorrect("Incorrect", messageText: "This ion has no electrons")
            }
            //if condition is referring to all ions except H+
        } else if atomicnumber >= 22 && atomicnumber <= 35 {
            if NumberElectronsInEachShell[0] != 2 {
                //final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                //  textViewToChange.setText("This ion requires 2 electrons in shell 1");
                //setIncorrect();
                setAlertIncorrect("Incorrect", messageText: "This ion requires 2 electrons in shell 1")
                //the ions H-, Li+ and Be2+ (all have just 2 electrons in shell 1)
            } else if atomicnumber >= 22 && atomicnumber <= 24 {
                if touchcanvasnumber != 2 {
                    // final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                    //  textViewToChange.setText("This ion has only 2 electrons");
                    //setIncorrect();
                    setAlertIncorrect("Incorrect", messageText: "This ion has only 2 electrons")
                } else if NumberElectronsInEachShell[1] != 0 && NumberElectronsInEachShell[2] != 0 {
                    // final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                    // textViewToChange.setText("This ion has no electrons in shells 2 or 3");
                    //setIncorrect();
                    setAlertIncorrect("Incorrect", messageText: "This ion no electrons in shells 2 and 3")
                } else {
                   // setCorrect();
                    setAlertCorrect("Correct!", messageText: "Well Done!")
                }
            } else if atomicnumber >= 25 && atomicnumber <= 30 {
                if touchcanvasnumber != 10 {
                    // final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                    //  textViewToChange.setText("This ion has 10 electrons");
                   // setIncorrect();
                    setAlertIncorrect("Incorrect", messageText: "This ion has 10 electrons")
                } else if NumberElectronsInEachShell[2] != 0 {
                    // final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                    // textViewToChange.setText("This ion has no electrons in shell 3");
                    //setIncorrect();
                    setAlertIncorrect("Incorrect", messageText: "This ion has no electrons in shell 3")
                } else {
                   // setCorrect();
                    setAlertCorrect("Correct!", messageText: "Well Done!")
                                   }
            } else if atomicnumber >= 31 && atomicnumber <= 35 {
                if touchcanvasnumber != 18 {
                    setAlertIncorrect("Incorrect", messageText: "This ion has 18 electrons")
                } else if NumberElectronsInEachShell[2] != 8 {
                    // final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                    // textViewToChange.setText("This ion has 8 electrons in shell 3");
                    //setIncorrect();
                    setAlertIncorrect("Incorrect", messageText: "This ion has 8 electrons in shell 3")
                } else {
                   // setCorrect();
                    setAlertCorrect("Correct!", messageText: "Well Done!")
                }
            }
        }
    }
    
    
    //check that there are the correct number of electrons in the outer shell
    func level1and2CheckAnswer(lowerElimit: Int, upperElimit: Int, shell: Int, EinPreviousShells: Int) {
        if atomicnumber >= lowerElimit && atomicnumber <= upperElimit && !correct {
            
            if NumberElectronsInEachShell[shell] == atomicnumber - EinPreviousShells {
               // setCorrect();
                setAlertCorrect("Correct!", messageText: "Well Done!")
                         } else {
                // final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
                // textViewToChange.setText("Too many electrons in a shell");
               // setIncorrect();
                setAlertIncorrect("Incorrect", messageText: "Too many electrons in a shell")
            }
        } else {
            //final TextView textViewToChange = (TextView) findViewById(R.id.HintForWrong);
            // textViewToChange.setText("Maximum of 2 electrons in shell 1, 8 electrons in shells 2 and 3");
            //setIncorrect();
            setAlertIncorrect("Incorrect", messageText: "Maximum of 2 electrons in shell 1, 8 electrons in shells 2 and 3")
        }
    }
    
    func setAlertIncorrect(titleText: String, messageText: String) {
    // Initialize Alert Controller
    let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
    
    // Initialize Action
    let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
        
    }
    //change height of alert controller
      //  let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.30)
        
     //   alertController.view.addConstraint(height)
        
    // Present Alert Controller
    self.presentViewController(alertController, animated: true, completion: nil)
       // let sadfaceImage = UIImage(named: "sadface")
        
       // let imageView = UIImageView(frame: CGRectMake(100, 75, 70, 70))
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
        
       // var error: NSError?
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
    
    func setAlertCorrect(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { action in
            if (self.playChoice == 11 && self.atomicnumber == 20) || (self.playChoice == 13 && self.atomicnumber == 35) {
                self.performSegueWithIdentifier("ShellsToCompletedLevel", sender: self)
            } else if self.playChoice > 30 {
               self.performSegueWithIdentifier("ShellsToPEN", sender: self)
                self.oldatomicnumber = self.atomicnumber
                        } else if self.playChoice < 30 {
                            self.setNextElement()
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
        
      //  var error: NSError?
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
    
    func setGeneralAlert(titleText: String, messageText: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .Alert)
        
        // Initialize Action
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in }
                self.presentViewController(alertController, animated: true, completion: nil)
        //add actions
                alertController.addAction(okAction)
    }
    
    
    @IBAction func previousButton(sender: AnyObject) {
        
      
        if atomicnumber < 2 && (playChoice == 11 || playChoice == 13 || playChoice == 31 || playChoice == 33) {
                setGeneralAlert("No Smaller Elements", messageText: "No Smaller Elements Available")
            } else {
            switch playChoice {
            case 11:
            --atomicnumber
            case 31:
               --atomicnumber
            case 13:
                getPreviousAtomthenIon()
            case 33:
                getPreviousAtomthenIon()
            default:
                
                if oldatomicnumber == atomicnumber {
                    setGeneralAlert("Sorry!", messageText: "No more previous elements saved")
                } else {
                    atomicnumber = oldatomicnumber
                    
                }
            }
        }
        
        //reset the elementImage
        reset()
    }
    
    
    @IBAction func nextButton(sender: AnyObject) {
        nextButtonCode()
    }
    
    
    func nextButtonCode() {
        if (atomicnumber == 20 && (playChoice == 11 || playChoice == 31)) ||
            (atomicnumber == 35 && (playChoice == 13 || playChoice == 33)) {
                setGeneralAlert("No More Elements", messageText: "No larger elements available")
                //concirclesView.setToast("No larger elements available");
        } else {
            setNextElement()
        }
    }
    
    @IBAction func undoButton(sender: AnyObject) {
        undoButtonCode()
           }
    
    @IBAction func undoButtonLandscape(sender: AnyObject) {
        undoButtonCode()
    }
    
    func undoButtonCode() {
        // undo = true;
        //  changeelement = true;
        if touchcanvasnumber == 0 {
            // setToast("There are no electrons left to remove");
            setGeneralAlert("Warning", messageText: "No electrons to remove")
            resetElectronsToZero()
            
            for var i=0; i<20; i++ {
                ZvalueElectronPosition[i] = 0
                elecposXArray[i] = 0
                elecposYArray[i] = 0
            }
        } else {
            --touchcanvasnumber
            ZvalueElectronPosition[touchcanvasnumber] = 0
            elecposXArray[touchcanvasnumber] = 0
            elecposYArray[touchcanvasnumber] = 0
            electronsArray[touchcanvasnumber].frame.origin = CGPointMake(0, 0)
            electronsArray[touchcanvasnumber].hidden = true
            
        }
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        reset()
    }
    
    @IBAction func clearButtonLandscape(sender: AnyObject) {
        reset()
    }
    
    
    func setNextElement() {
        
        oldatomicnumber = atomicnumber
        //setNextElement
    setAtomicnumber()
        reset()
       
    }
    
    func setAtomicnumber() {
                if playChoice == 11 || playChoice == 31 {
            ++atomicnumber
                               //'previousPressedInPENScreen' required because otherwise ShellsScreen will treat it as a 'next'.
            //When user presses previous in PEN Screen, 'previousPressedInPENScreen' changes to a 1, hence allowing
            //choices here
            
        } else if playChoice == 13 || (playChoice == 33 && fromBackInPENScreen == false) {
            //method to call to choose which element/ion to bring up next.  I think the atomionLabel array will
            //have to be ordered as atomthenion, or maybe not?  Maybe I will have to go through each element/ion
            //individually and specify which element/ion to bring up next, to amke it go in order.  There are
            //quite a few that will just be atomicnumber++, then just do other separately
              getNextAtomThenIon()
        }
        else if playChoice == 33 && fromBackInPENScreen == true {
             getPreviousAtomthenIon()
            //reset previousPressedInPENScreen to false, because this has now been used for the purpose intended i.e.
            //to tell ShellsScreen that the user clicked the previous button in the PENScreen.
            fromBackInPENScreen = false
        } else if playChoice == 12 || playChoice == 32 {
            atomicnumber = Int(arc4random_uniform(20) + 1)
            //atomicnumber = 1 + (int) (Math.random() * ((20 - 1) + 1));
        } else if playChoice == 14 || playChoice == 34 {
            atomicnumber = Int(arc4random_uniform(15) + 21)
        } else if playChoice == 15 || playChoice == 16 || playChoice == 35 || playChoice == 36 {
            atomicnumber = Int(arc4random_uniform(35) + 1)
        }
        
    }
    
    func reset() {
        
        touchcanvasnumber = 0
    //changeelement = true
    NumberElectronsInEachShell = [0,0,0,0]
    resetElectronsToZero()
        //change element image
        self.elementImage.image = UIImage(named: elementImagesArray[atomicnumber])
        //make all electrons invisible
        for var i=0; i < 20; i++ {
            electronsArray[i].frame.origin = CGPoint(x: 0, y: 0)
        electronsArray[i].hidden = true
        }
        }
    
    func resetElectronsToZero() {
   
    ZvalueElectronPosition = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        elecposXArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    elecposYArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
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
        
        func getPreviousAtomthenIon() {
            if atomicnumber == 19 || atomicnumber == 15 ||
                atomicnumber == 11 || atomicnumber == 7 ||
                atomicnumber == 6 || atomicnumber == 3 ||
                atomicnumber == 22  {
                    --atomicnumber
            } else if atomicnumber == 2  {
                atomicnumber = atomicnumber + 20
            } else if atomicnumber == 21 || atomicnumber == 23 || atomicnumber == 24 {
                atomicnumber = atomicnumber - 20
            } else if atomicnumber == 4 || atomicnumber == 5 {
                atomicnumber = atomicnumber + 19
            } else if atomicnumber == 25 || atomicnumber == 26 || atomicnumber == 27 {
                atomicnumber = atomicnumber - 18
            } else if atomicnumber == 8 || atomicnumber == 9 || atomicnumber == 10 {
                atomicnumber = atomicnumber + 17
            } else if atomicnumber == 29 || atomicnumber == 30 || atomicnumber == 28 {
                atomicnumber = atomicnumber - 17
            } else if atomicnumber == 12 || atomicnumber == 13 || atomicnumber == 14 {
                atomicnumber = atomicnumber + 16
            } else if atomicnumber == 31 || atomicnumber == 32 || atomicnumber == 33 {
                atomicnumber = atomicnumber - 16
            } else if atomicnumber == 16 || atomicnumber == 17 || atomicnumber == 18 {
                atomicnumber = atomicnumber + 15
            } else if atomicnumber == 34 || atomicnumber == 35 {
                atomicnumber = atomicnumber - 15
            } else if atomicnumber == 20 {
                atomicnumber = atomicnumber + 14
            }
        }
    
    func payUp() {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShellsToPEN" {
            let vc = segue.destinationViewController as! PENScreenViewController
            let DestViewController : PENScreenViewController = segue.destinationViewController as! PENScreenViewController
            DestViewController.playChoice = Int(playChoice)
            DestViewController.elementSymbolNumber = Int(atomicnumber)
            vc.delegate = self
        } else if segue.identifier == "ShellsToCompletedLevel" {
            let DestViewController : LevelCompletedViewController = segue.destinationViewController as! LevelCompletedViewController
            DestViewController.playChoice = Int(playChoice)
          DestViewController.firstTimeCompletedLevel = Bool(firstTimeShells)
        }
    }
    

}
