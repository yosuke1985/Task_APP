//
//  NoteTableViewCell.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/07/02.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit
import RealmSwift

class NoteTableViewCell: UITableViewCell, UITextViewDelegate {
    var task:Task?
    let realm = try! Realm()

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func textViewDidChange(_ textView: UITextView){
        
        try! realm.write {
            task?.notes = textView.text
            task?.UpdatedAt = NSDate()
            realm.add(task!)
        }
        
    }

    
}
