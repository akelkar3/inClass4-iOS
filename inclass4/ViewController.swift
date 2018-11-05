//
//  ViewController.swift
//  inclass4
//
//  Created by Ankit Kelkar on 11/2/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let LengthVal:[Int] = [5,8,15,25]
    var length:Int = 1000
    var count:Int = 0
    var dataTOsend:[String] = []
    @IBOutlet weak var numP: UITextField!
    @IBOutlet weak var selectedPassword: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    @IBAction func createPass(_ sender: Any) {
        var temp = 0
        
        if let num = self.numP.text{
            if (num != "") && (self.length != 1000){
                dataTOsend = []
                DispatchQueue.global(qos:.userInteractive).async {
                    temp = Int(self.numP.text!) ?? 1000
                    for i in 0..<temp {
                        self.dataTOsend.append(AppsData.getPassword(len: self.length))
                    }
                    
                    DispatchQueue.main.async {
                        // self.tableView.reloadData()
                        
                        print("completed with passwords \(self.dataTOsend)")
                        // print("completed")
                        self.performSegue(withIdentifier: "showPassSegue", sender: self)
                        
                    }
                }
            }
            else{
                showAlertMessage()
            }
        }
       // let dataTOsend = ["1","2","3"]
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue called")
       

        let destination = segue.destination as! CreateTableTableViewController
     destination.data=dataTOsend
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lengthCell", for: indexPath)
        
        let lable = cell.viewWithTag(2) as! UILabel
        // Configure the cell...
        switch indexPath.row {
        case 0:
            lable.text = "Weak (Length 5)"
            break
        case 1:
            lable.text = "Medium (Length 8)"
            break
        case 2:
            lable.text = "Strong (Length 15)"
            break
        case 3:
            lable.text = "Extra Strong (Length 25)"
            break
        default:
            lable.text = "empty "
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        print("selected the row")
        self.length = LengthVal[ indexPath.row]
        
    }
    
    @IBAction func unwindToVCWithSegue(segue:UIStoryboardSegue) {
    
    }
    func showAlertMessage(){
        let alert = UIAlertController(title: "Blank Fields", message: "Please enter all the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }


}

