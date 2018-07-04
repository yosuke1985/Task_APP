//
//  ViewController.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/06/27.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import SwiftyJSON



class TaskHomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, AddTaskTableViewCellDelegate,TaskListTableViewCellDelegate{

    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    var allTask:[Task]?
    var taskCount:Int = 0
    var ref:DatabaseReference!

    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AddTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "addTask")
        tableView.register(UINib(nibName: "TaskListTableViewCell", bundle: nil), forCellReuseIdentifier: "taskList")
        reload()
        //Firebaseにアップロードする
        ref = Database.database().reference()
        // Realm からデータの取得
        let objects = Task.loadAll()
        print("objects", objects)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
 
        for object in objects{
            print(object.task_name)
            var data:[String:Any] = [:]
            data["task_name"] = object.task_name
            data["notes"] = object.notes
            data["list"] = object.list
            data["done"] = object.done
            if object.UpdatedAt != nil{
                let myString = formatter.string(from: object.UpdatedAt! as Date)
                data["UpdatedAt"] = myString
            }
            
            if object.CreatedAt != nil{
                let myString = formatter.string(from: object.CreatedAt! as Date)
                data["CreatedAt"] = myString
            }
            ref.child("Task").child(String(object.id)).updateChildValues(data)
        }
        
        //取得
        ref.child("Task").observe(.value , with: { (snapshot: DataSnapshot) in
            //JSON形式でもらいたい　オートIDから
            let getjson = JSON(snapshot.value as? [String : AnyObject] ?? [:])
            //データが0件の場合何もしない
            if getjson.count == 0 { return }
            //keyから辞書型、"msg"の内容を代入 "\n"は改行
            for (key, val) in getjson.dictionaryValue {
                //key情報と入力した文字を表示する
                print("key",key)
                print("value",val)
            }
        })
        
        
        super.viewDidLoad()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload(){
        //安全になにか書いたほうがよさげ
        allTask = Task.loadAll()
        taskCount = (allTask?.count)!
        
        
    }
    
    func goToDetail(sender: Task){
        //data[indexPath.row]
        performSegue(withIdentifier: "detail", sender: sender)

    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let nextVC = segue.destination as! TaskDetailViewController
        print(nextVC.view)
        print("prepare(for segue", sender!)

        nextVC.task = sender as? Task
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskCount + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    


    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // indexPath.rowが0からallTask.count -1まで
        if indexPath.row <= taskCount - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskList", for: indexPath) as! TaskListTableViewCell
            cell.textField.text = allTask?[indexPath.row].task_name
            //安全？
            cell.checkBox.on = (allTask?[indexPath.row].done)!
            cell.task = (allTask?[indexPath.row])!
            cell.delegate = self
            return cell
        }else{
            //indexPath.rowがallTask.count部分にaddTaskCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "addTask", for: indexPath) as! AddTaskTableViewCell
            cell.delegate = self
        
            return cell
        }
    }

    
    func relaod() {
        reload()
        tableView.reloadData()
    }
    

}

