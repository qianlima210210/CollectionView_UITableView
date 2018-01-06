//
//  CommunicationListTableViewController.swift
//  CommunicationList
//
//  Created by QDHL on 2017/12/30.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class CommunicationListTableViewController: UITableViewController {

    var array = [Person]()
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "detailSegue", sender:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createTableHeaderView()
        self.createTableFooterView()
        
        self.loadData {
            self.tableView.reloadData()
            

        }
    }
    
    // 创建表头标签
    func createTableHeaderView() -> Void {
        let bounds = view.bounds
        
        let headerLabel = UILabel.init(frame: CGRect(x:0, y:0, width:bounds.width, height:30))
        headerLabel.backgroundColor = UIColor.yellow
        headerLabel.textColor = UIColor.red
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = "tableHeaderView"
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        tableView.tableHeaderView = headerLabel
    }
    // 创建表尾标签
    func createTableFooterView() -> Void {
        let bounds = view.bounds
        
        let footerLabel = UILabel.init(frame: CGRect(x:0, y:0, width:bounds.width, height:60))
        footerLabel.backgroundColor = UIColor.yellow
        footerLabel.textColor = UIColor.red
        footerLabel.numberOfLines = 0
        footerLabel.lineBreakMode = .byWordWrapping
        footerLabel.text = "tableFooterView"
        footerLabel.textAlignment = NSTextAlignment.center
        footerLabel.font = UIFont.systemFont(ofSize: 15)
        tableView.tableFooterView = footerLabel
    }

    //异步加载数据
    func loadData(complete: @escaping () -> ()) -> Void {
        
        let queue = DispatchQueue(label: "queue", attributes: .concurrent)
        queue.async {
             Thread.sleep(forTimeInterval: 1.0)
            
            for i in 0..<5{
                let p = Person(name: "name_\(i)", telNum: "telNum_\(i)", title: "title_\(i)")
                self.array.append(p)
            }
            
            DispatchQueue.main.async {
                complete()
            }
        }
    }
    
    deinit {
        print("CommunicationListTableViewController: deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! PersonTableViewCell
        let p = array[indexPath.row]
        cell.nameTable.text = p.name
        cell.telLabel.text = p.telNum
        cell.titleLabel.text = p.title
        
        return cell
    }
    
    //MARK: - Table view data delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "detailSegue", sender:indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bounds = view.bounds
        
        let headerLabel = UILabel.init(frame: CGRect(x:0, y:0, width:bounds.width, height:60))
        headerLabel.backgroundColor = UIColor.blue
        headerLabel.textColor = UIColor.red
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = "viewForHeaderInSection"
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let bounds = view.bounds
        
        let footerLabel = UILabel.init(frame: CGRect(x:0, y:0, width:bounds.width, height:60))
        footerLabel.backgroundColor = UIColor.blue
        footerLabel.textColor = UIColor.red
        footerLabel.numberOfLines = 0
        footerLabel.lineBreakMode = .byWordWrapping
        footerLabel.text = "viewForFooterInSection"
        footerLabel.textAlignment = NSTextAlignment.center
        footerLabel.font = UIFont.systemFont(ofSize: 15)
        
        return footerLabel
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("\(segue.destination)---\(segue.identifier ?? "")")
        let destination = segue.destination as! DetailTableViewController
        if let indexPath = sender as? IndexPath {
            destination.person = array[indexPath.row]
            destination.saveCallback = {(person) in
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }else{
            
            destination.saveCallback = { (person) in
                self.array.insert(person!, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    

}
