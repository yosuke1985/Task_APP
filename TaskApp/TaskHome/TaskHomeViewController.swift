//
//  ViewController.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/06/27.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit
import RealmSwift

class TaskHomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var allTask:[Task]?
    var taskCount:Int = 0
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "AddTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "addTask")
        tableView.register(UINib(nibName: "TaskListTableViewCell", bundle: nil), forCellReuseIdentifier: "taskList")

        //安全になにか書いたほうがよさげ
        allTask = Task.loadAll()
        taskCount = (allTask?.count)!
        

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskCount + 1
    }
    
    

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // indexPath.rowが0からallTask.count -1まで
        if indexPath.row <= taskCount - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskList", for: indexPath) as! TaskListTableViewCell
            cell.textField.text = allTask?[indexPath.row].task_name
            //安全？
            cell.checkBox.on = (allTask?[indexPath.row].done)!
            cell.task = (allTask?[indexPath.row])!
            return cell
        }else{
            //indexPath.rowがallTask.count部分にaddTaskCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "addTask", for: indexPath) as! AddTaskTableViewCell
            return cell
        }
    }

    

}

