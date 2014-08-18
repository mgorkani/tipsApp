//
//  ViewController.swift
//  tips
//
//  Created by Monika Gorkani on 8/13/14.
//  Copyright (c) 2014 Monika Gorkani/Users/monika/sampleIOS/tips/SettingsViewController.swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tipPercentages : [Double] = [0.0,0.0,0.0]
    var animated = false;
                            
    @IBOutlet weak var tipLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        totalLabel.text = "$0.00"
        totalLabel.hidden = true
        tipLabel.text = "$0.00"
        tipLabel.hidden = true
        tipControl.hidden = true
        var totalLabelFrame = self.totalLabel.frame
        totalLabelFrame.origin.y += 100
        var billFieldFrame = self.billField.frame
        billFieldFrame.origin.y += 100
        var tipControlFrame = self.tipControl.frame
        tipControlFrame.origin.y += 100
        var tipLabelFrame = self.tipLabel.frame
        tipLabelFrame.origin.y += 100
        self.totalLabel.frame = totalLabelFrame
        self.billField.frame = billFieldFrame
        self.tipControl.frame = tipControlFrame
        self.tipLabel.frame = tipLabelFrame
        
       
        
        
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        let defaults = NSUserDefaults.standardUserDefaults()
        var goodValue = defaults.integerForKey("goodPercentage")
        if (goodValue == 0)
        {
            goodValue = 18;
            
        }
        var verySatisValue = defaults.integerForKey("verySatisPercentage")
        if (verySatisValue == 0)
        {
            verySatisValue = 20;
        }
        var excellentValue = defaults.integerForKey("excellentPercentage")
        if (excellentValue == 0)
        {
            excellentValue = 22;
        }
        tipControl.setTitle("\(goodValue)%",forSegmentAtIndex:0)
        tipControl.setTitle("\(verySatisValue)%",forSegmentAtIndex:1)
        tipControl.setTitle("\(excellentValue)%",forSegmentAtIndex:2)
        tipPercentages[0] = Double(goodValue)/100
        tipPercentages[1] = Double(verySatisValue)/100
        tipPercentages[2] = Double(excellentValue)/100
        
        let billValue = defaults.stringForKey("billValue");
        if (billValue) {
            let lastSecs = defaults.integerForKey("lastSetDate")
            if (lastSecs > 0) {
                let nowSecs = Int(NSDate().timeIntervalSince1970)
                if ((nowSecs - lastSecs) < 60) {
                    billField.text = billValue
                 
                    tipControl.hidden = false
                    tipLabel.hidden = false
                    tipControl.hidden = false
                }
                else {
                    defaults.setValue("",forKey:"billValue")
                    defaults.setInteger(0,forKey:"lastSetDate")
                    defaults.synchronize()
                }
            }
            
        }
        
        
        
        
    }
    
    
    
    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var totalLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
      
        if (!animated) {
            animated = true;
            UIView.animateWithDuration(1.0, delay: 0, options: .CurveEaseOut, animations: {
                
                var totalLabelFrame = self.totalLabel.frame
                totalLabelFrame.origin.y -= 100
                var billFieldFrame = self.billField.frame
                billFieldFrame.origin.y -= 100
                var tipControlFrame = self.tipControl.frame
                tipControlFrame.origin.y -= 100
                var tipLabelFrame = self.tipLabel.frame
                tipLabelFrame.origin.y -= 100
                self.totalLabel.frame = totalLabelFrame
                self.billField.frame = billFieldFrame
                self.tipControl.frame = tipControlFrame
                self.tipLabel.frame = tipLabelFrame
                self.tipLabel.hidden = false
                self.tipControl.hidden = false
                self.totalLabel.hidden = false
                
                
                }, completion: { finished in
                    println("Napkins opened!")
                })
        }
       
        var billAmount = billField.text.bridgeToObjectiveC().doubleValue;
        
        
       
        var tip = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        var total = billAmount + tip
        totalLabel.text = String(format:"$%.2f",total)
        tipLabel.text = String(format:"$%.2f",tip)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(billField.text,forKey:"billValue")
    defaults.setInteger(Int(NSDate().timeIntervalSince1970),forKey:"lastSetDate")
        defaults.synchronize()
    }

   
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

