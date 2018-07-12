//
//  Task.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/07/11.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import Foundation
import Firebase
// Refactoring Task

struct TaskModel {
    
//    let ref: DatabaseReference?
//    let key: String

    let id:Int
    let task_name:String
    let notes:String
    let list:String
    let done:Bool
    let UpdatedAt:NSDate?
    let CreatedAt:NSDate?
    
    
    init(id: Int, task_name: String, notes: String, list: String, done:Bool = false,UpdatedAt:NSDate, CreatedAt:NSDate ) {
        self.id = id
        self.task_name = task_name
        self.notes = notes
        self.list = list
        self.done = done
        self.UpdatedAt = UpdatedAt
        self.CreatedAt = CreatedAt
    }
    
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let task_name = value["task_name"] as? String,
//            let notes = value["notes"] as? String,
//            let done = value["done"] as? Bool
//            else {
//                return nil
//        }
//
//        self.ref = snapshot.ref
//        self.uid = snapshot.key
//
//
//    }


}
