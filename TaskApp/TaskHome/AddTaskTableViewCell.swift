//
//  TaskTableViewCell.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/06/28.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit

class AddTaskTableViewCell: UITableViewCell, UITextFieldDelegate {

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
    
    @IBAction func addTask(_ sender: Any) {
        print("from addTask func")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        let test = textField.text
        print(test)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    
    
}
