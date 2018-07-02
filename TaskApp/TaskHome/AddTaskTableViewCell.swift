//
//  TaskTableViewCell.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/06/28.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit
import RealmSwift

protocol realaodTable {
    func relaod()
}

class AddTaskTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    let realm = try! Realm()
    var delegate:realaodTable?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        textField.resignFirstResponder()

        guard let taskname = textField.text else {return true}
        let new = Task.create()
        new.task_name = taskname
        new.save()
        textField.text = nil
        
        delegate?.relaod()
        
        
        return true
    }
    
    
    
    
    
}
