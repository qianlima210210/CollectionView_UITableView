/*
 Thread quality of service (QOS服务质量，即线程优先级):
 
 
*/

import UIKit

class RootViewController: UIViewController {

    
    @IBAction func intoCommunication(_ sender: UIButton) {
        self.performSegue(withIdentifier: "intoCommunicationSegue", sender:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("\(segue.destination)---\(segue.identifier ?? "")")
    }
    

}
