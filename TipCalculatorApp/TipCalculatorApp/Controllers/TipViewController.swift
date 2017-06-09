//
//  TipViewController.swift
//  TipCalculatorApp
//
//  Created by Hoang on 6/7/17.
//  Copyright © 2017 Kins Solutions. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak private var amountTextField:UITextField!
    @IBOutlet weak private var tipAmountLabel:UILabel!
    @IBOutlet weak private var totalLabel:UILabel!
    @IBOutlet weak private var percentSegment:UISegmentedControl!
    
    
    // MARK: - Private properties
    private var percent:Float = 0.15
    
    private var tapGesture:UITapGestureRecognizer!
    
    // MARK: - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.amountTextField.addTarget(self, action: #selector(TipViewController.billAmountChanged(_:)), for: UIControlEvents.editingChanged)
        let index = self.getPercentIndex()
        self.percent = self.percentAtIndex(index)
        self.percentSegment.selectedSegmentIndex = index
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(TipViewController.tap(_:)))
        
        NotificationCenter.default.addObserver(self, selector:#selector(TipViewController.keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(TipViewController.keyboardWillDisappear(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        amountTextField.becomeFirstResponder()
        
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "default_tip_index")
        
        self.percent = self.percentAtIndex(defaultTipIndex)
        self.percentSegment.selectedSegmentIndex = defaultTipIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func percentAtIndex(_ index: Int) -> Float {
        switch index {
        case 1:
            return 0.20
        case 2:
            return 0.25
        default:
            return 0.15
        }
    }
    
    func keyboardWillAppear(_ notification: NSNotification){
        // Do something here
        self.view.addGestureRecognizer(self.tapGesture)
    }
    
    func keyboardWillDisappear(_ notification: NSNotification){
        // Do something here
        self.view.removeGestureRecognizer(self.tapGesture)
    }

    func tap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func storePercentIndex(_ index: Int) {
        let userDefault = UserDefaults.standard
        userDefault.set(index, forKey: "index")
        userDefault.synchronize()
    }
    
    private func getPercentIndex() -> Int {
        let userDefault = UserDefaults.standard
        let index = userDefault.integer(forKey: "index")
        return index
    }
    
    // MARK: - IBActions
    @IBAction private func settingPressed(_ sender: Any) {
    
    }
    
    @IBAction private func percentChanged(_ sender: Any) {
        let index = (sender as! UISegmentedControl).selectedSegmentIndex
        storePercentIndex(index)
        
        self.percent = self.percentAtIndex(index)
        self.billAmountChanged(self.amountTextField)
    }
    
    func billAmountChanged(_ sender: UITextField) {
        if let text = sender.text, let tmp = Float(text) {
            let number = (tmp * self.percent) + tmp
            self.totalLabel.text = "$" + number.formattedWithSeparator.description
            self.tipAmountLabel.text = "$" + (tmp * self.percent).formattedWithSeparator.description
        } else {
            self.totalLabel.text = "$0.00"
        }
    }
}
