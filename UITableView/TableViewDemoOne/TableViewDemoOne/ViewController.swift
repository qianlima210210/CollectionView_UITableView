//
//  ViewController.swift
//  TableViewDemoOne
//
//  Created by QDHL on 2018/1/3.
//  Copyright © 2018年 QDHL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView:UITableView!
    var allNames:Dictionary<Int, [String]>!
    var addHeaders:[String]!
    var checkIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        allNames =
            [
                0:[String](["UILabel 标签", "UITextField 文本框", "UIButton 按钮"]),
                1:[String](["UIDatePiker 日期选择器", "TableView 表格视图", "UIToolbar 工具条", "UIWebView 浏览器"])
        ]
        
        addHeaders = ["常见 UIKit 控件","高级 UIKit 控件"]
        
        // 创建表格
        tableView = UITableView.init(frame: self.view.frame, style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view .addSubview(tableView)
        
        // 注册cell
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 创建表头标签
        let headerLabel = UILabel.init(frame: CGRect(x:0, y:20, width:375, height:30))
        headerLabel.backgroundColor = UIColor.yellow
        headerLabel.textColor = UIColor.red
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = "高级 UIKit"
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        tableView.tableHeaderView = headerLabel
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        longPress.minimumPressDuration = 1
        tableView .addGestureRecognizer(longPress)
        
    }
    
    @objc func longPressAction(recognizer:UILongPressGestureRecognizer)  {
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            if tableView.isEditing == true {
                tableView.isEditing = false
            }
            else
            {
                tableView.isEditing = true
            }
            
            tableView.reloadData()
        }
    }
    
    // 创建分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return allNames.count
    }
    
    // 每个分区的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count =  allNames[section]!.count
        
        if tableView.isEditing {
            count += 1
        }
        
        return count
    }
    
    // 分区头部显示
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return addHeaders[section]
    }
    
    // 分区尾部显示
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let data = allNames[section]
        return "有\(data!.count)个控件"
    }
    
    // 显示cell内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "cell"
        
        let secno = indexPath.section
        let data = allNames[secno]
        var cell = UITableViewCell()
        cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: identify)
        if secno == 0 {
            
            if tableView.isEditing && indexPath.row == data?.count {
                cell.textLabel?.text = "添加新数据..."
            }else{
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = data?[indexPath.row]
            }
            
        }
        else
        {
            if tableView.isEditing && indexPath.row == data?.count {
                cell.textLabel?.text = "添加新数据..."
            }else{
                cell.textLabel?.text = data?[indexPath.row]
                cell.detailTextLabel?.text = "\(data![indexPath.row])的详解"
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    //MARK: --UITableViewDelegate
    // 设置单元格的编辑的样式
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let secno = indexPath.section
        let data = allNames[secno]

        if tableView.isEditing && indexPath.row == data?.count {
            return UITableViewCellEditingStyle.insert
        }else{
            return UITableViewCellEditingStyle.delete
        }
    }
    
    // 设置确认删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "确认删除"
    }
    
    //多个按钮，实现了这个方法后上面方法失效
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "请删除") { (action, indexPath) in
            print("deleteAction")
        }

        let addAction = UITableViewRowAction(style: .normal, title: "添加") { (action, indexPath) in
            print("addAction")
        }

        let otherAction = UITableViewRowAction(style: .destructive, title: "其他") { (action, indexPath) in
            print("otherAction")
        }

        return [deleteAction, addAction, otherAction]
    }
    
    // 单元格编辑后的响应方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.allNames[indexPath.section]?.remove(at: indexPath.row)
        }

        else if editingStyle == UITableViewCellEditingStyle.insert
        {
            allNames[indexPath.section]?.insert("插入的", at: indexPath.row)
        }

        tableView.reloadData()
    }
    
    //控制√的有无
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let checkIndexPath = checkIndexPath {

            if checkIndexPath.row == indexPath.row {//取消自己
                if let cell = tableView.cellForRow(at: checkIndexPath) {
                    cell.accessoryType = .none
                }

                self.checkIndexPath = nil

            }else{//取消其他cell

                if let cell = tableView.cellForRow(at: checkIndexPath) {
                    cell.accessoryType = .none
                }

                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .checkmark
                }

                self.checkIndexPath = indexPath

            }
        }else{
            checkIndexPath = indexPath
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //下面移动两个方法一起使用
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}

