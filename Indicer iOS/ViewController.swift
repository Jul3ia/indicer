//  ViewController.swift
//  Indicer
//
//  Created by Jul3ia on 2/12/16.
//  Copyright © 2016 Island Pixel Works. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var index: Int!
    let indices: [String] = ["one", "two", "three"]

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var indexSelectorOutlet: UISegmentedControl!
    
    // MARK: view cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set default values
        index = 0
        self.updateTextLabel()
        self.indexSelectorOutlet.selectedSegmentIndex = index
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UI stuff
    
    func updateTextLabel() {
        self.indexLabel.text = "Index: \(index)"
        self.indexSelectorOutlet.selectedSegmentIndex = index
    }
    
    @IBAction func selectIndex(sender: AnyObject) {
        self.numberField.text = ""
        switch (self.indexSelectorOutlet.selectedSegmentIndex) {
        case 0:
            index = 0
            self.updateTextLabel()
        case 1:
            index = 1
            self.updateTextLabel()
        case 2:
            index = 2
            self.updateTextLabel()
        default:
            index = 0
            self.updateTextLabel()
        }
    }
    
    @IBAction func incrementIndex(sender: AnyObject) {
        //increment text field if a valid number already exists
        var inputted = Int(numberField.text!)
        if (inputted != nil) {
            inputted = inputted! + 1
            self.numberField.text = "\(inputted as Int!)"
        }
        //increment index number and segment controller
        if index < (indices.count - 1) && index >= 0 {
            index = index + 1
        } else {
            index = 0
        }
        self.updateTextLabel()
    }
    
    @IBAction func decrementIndex(sender: AnyObject) {
        //decrement text field if a valid number already exists
        var inputted = Int(numberField.text!)
        if (inputted != nil) {
            inputted = inputted! - 1
            self.numberField.text = "\(inputted as Int!)"
        }
        //decrement index number and segment controller
        if index <= indices.count && index > 0 {
            index = index - 1
        } else {
            index = indices.count - 1
        }
        self.updateTextLabel()
    }
    
    // MARK: calculator
    
    @IBAction func calculateIndex(sender: AnyObject) {
        
        //grab text field input
        let inputted = Int(numberField.text!)
        
        //check if nil
        if (inputted != nil) {
            
            //if inputted value is BEYOND index range
            if (inputted >= indices.count) {
                index = inputted! % indices.count
                self.indexSelectorOutlet.selectedSegmentIndex = index
                
                //if inputted value is WITHIN the index range
            } else if ((inputted < indices.count) && (inputted >= 0)) {
                index = inputted
                self.indexSelectorOutlet.selectedSegmentIndex = index
                
                //if inputted value is BEFORE index range
            } else if (inputted < 0) {
                index = (inputted! % indices.count)
                if index != 0 {
                    index = index + indices.count
                }
                
                //set UI stuff
                self.indexSelectorOutlet.selectedSegmentIndex = index
            }
            self.updateTextLabel()
            
            //if a valid number is not entered
        } else {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter a valid number", preferredStyle: (UIAlertControllerStyle .Alert))
            let ok = UIAlertAction(title: "OK", style: .Cancel) { _ in
            }
            alertController.addAction(ok)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
}