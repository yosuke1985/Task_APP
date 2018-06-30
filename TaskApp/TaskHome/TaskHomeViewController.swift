//
//  ViewController.swift
//  TaskApp
//
//  Created by YOSUKE on 2018/06/27.
//  Copyright © 2018 YOSUKE. All rights reserved.
//

import UIKit

class TaskHomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AddTaskTableViewCell", bundle: nil), forCellReuseIdentifier: "addTask")
        tableView.register(UINib(nibName: "TaskListTableViewCell", bundle: nil), forCellReuseIdentifier: "taskList")

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if indexPath.row==0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskList", for: indexPath) as! TaskListTableViewCell
            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addTask", for: indexPath) as! AddTaskTableViewCell
            return cell
            
        }

        
    }

    

}

