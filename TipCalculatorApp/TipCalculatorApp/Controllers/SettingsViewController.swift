//
//  SettingsViewController.swift
//  TipCalculatorApp
//
//  Created by Hoang on 6/7/17.
//  Copyright © 2017 Kins Solutions. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate,
    UIPickerViewDataSource {

    @IBOutlet var defaultTipText: UIView!
    
    @IBOutlet weak var defaultTipControl: UIPickerView!
    
    let pickerData: [Int] = [15, 20, 25]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Initialize picker data
        self.defaultTipControl.delegate = self
        self.defaultTipControl.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "default_tip_index")
        self.defaultTipControl.selectRow(defaultTipIndex, inComponent: 0, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row]) + "%"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "default_tip_index")
        defaults.synchronize()
    }

}
