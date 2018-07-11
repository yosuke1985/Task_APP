//
//  realmDB.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/07/02.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    //Realmクラスのインスタンス
    static let realm = try! Realm()
    @objc dynamic var id = 0
    @objc dynamic var task_name = ""
    @objc dynamic var notes = ""
    @objc dynamic var list = ""
    @objc dynamic var done = false
    @objc dynamic var UpdatedAt:NSDate? = nil
    @objc dynamic var CreatedAt:NSDate? = nil

    
    override static func primaryKey() -> String? {
        return "id"
    }
    //Create新規追加用インスタンス生成メソッド
    static func create() -> Task {
        let res = Task()
        res.id = lastId()
        res.CreatedAt = NSDate()
        return res
    }
    
    //インスタンス保存用のメソッド
    func save() {
        try! Task.realm.write {
            Task.realm.add(self)
        }
    }
    //インスタンス削除用メソッド
    func delete() {
        try! Task.realm.write {
            Task.realm.delete(self)
        }
    }
    //プライマリーキー作成メソッドlastID
    static func lastId() -> Int {
        if let res = realm.objects(Task.self).sorted(byKeyPath: "id").last {
            return res.id + 1
        }else {
            return 1
        }
    }
    //loadAll（順番はわからん読み込み順。並び替えしてない）
    static func loadAll() -> [Task] {
        let ress = realm.objects(Task.self)
        var resList: [Task] = []
        for res in ress {
            resList.append(res)
        }
        return resList
    }
    
    static func deleteAll(){
        let all = realm.objects(Task.self)
        for object in all{
            try! Task.realm.write {
                Task.realm.delete(object)
            }
            
        }
        
    }
}
