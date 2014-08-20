//
//  SettingsViewController.swift
//  tips
//
//  Created by Monika Gorkani on 8/13/14.
//  Copyright (c) 2014 Monika Gorkani. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBAction func goBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   

    @IBOutlet weak var goodTextField: UITextField!
    @IBOutlet weak var verySatisTextField: UITextField!
    @IBOutlet weak var excellentTextField: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        var defaults = NSUserDefaults.standardUserDefaults()
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
        goodTextField.text = "\(goodValue)";
        verySatisTextField.text = "\(verySatisValue)"
        excellentTextField.text = "\(excellentValue)"
        
    }

    
    @IBAction func percentageChanged(sender: UITextField) {
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if (sender == goodTextField)
        {
            let a:Int? = sender.text.toInt();
            if ((a) != nil) {
                defaults.setInteger(a!,forKey:"goodPercentage")
            }
            
        }
        
        if (sender == verySatisTextField)
        {
            let a:Int? = sender.text.toInt();
            if ((a) != nil) {
                defaults.setInteger(a!,forKey:"verySatisPercentage")
            }
            
        }
        
        if (sender == excellentTextField)
        {
            let a:Int? = sender.text.toInt();
            if ((a) != nil) {
                defaults.setInteger(a!,forKey:"excellentPercentage")
            }
            
        }
        defaults.synchronize()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
