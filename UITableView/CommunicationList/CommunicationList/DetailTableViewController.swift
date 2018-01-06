//
//  DetailTableViewController.swift
//  CommunicationList
//
//  Created by QDHL on 2017/12/30.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var person: Person?
    var saveCallback: ((_ person: Person? ) -> ())?
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var telTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if let person = person {
            person.name = nameTF.text
            person.telNum = telTF.text
            person.title = titleTF.text
            
            saveCallback?(nil)
        }else{
            person = Person(name: nameTF.text ?? "", telNum: telTF.text ?? "", title: titleTF.text ?? "")
            saveCallback?(person)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let person = person {
            nameTF.text = person.name
            telTF.text = person.telNum
            titleTF.text = person.title
        }
        
    }

    deinit {
        print("DetailTableViewController: deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
