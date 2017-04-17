//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Richards, Brandon S. on 4/13/17.
//  Copyright © 2017 Richards, Brandon S. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound = AVAudioPlayer.init()
    
    var runningNumber = ""
    
    enum operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = operation.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound =  AVAudioPlayer.init(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        outputLbl.text = "0"
    
    }
    
    @IBAction func numberPressed(sender: UIButton)
    {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePress(sender: UIButton) {
        processOperation(.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(.Multiply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperation(.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }

    
    func playSound() {
        if(btnSound.playing) {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(opper: operation){
        
        playSound()
        if(currentOperation != operation.Empty) {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                }
                else if currentOperation == operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }
                else if currentOperation == operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                else if currentOperation == operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
            }
            currentOperation = opper
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = opper
        }
    
    }



}


