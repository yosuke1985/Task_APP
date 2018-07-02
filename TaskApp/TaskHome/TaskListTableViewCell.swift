//
//  TaskListTableViewCell.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/06/30.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit

class TaskListTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var checkBox: CheckboxButton!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField){
        let test = textField.text
        print(test)
        
    } // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

    

    
    @IBAction func listTextField(_ sender: Any) {
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        textField.resignFirstResponder()
        
        return true
    }
    @IBAction func didToggleCheckboxButton(_ sender: CheckboxButton) {
        
        let state = sender.on ? "ON" : "OFF"
        
        print("CheckboxButton: did turn \(state)")
        
    }
    
}
