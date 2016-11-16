//
//  subjectTableViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/3.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit



class subjectTableViewController: UITableViewController {
    
    // MARK: Properties
    
    let questionSegueIdentifier = "showQuestionSegue"
    
    // MARK: - Navigation
    
    // example from http://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
    
    open var subjects = [Subject]()
    var questions1 = [Question]()
    var questions2 = [Question]()
    var questions3 = [Question]()
    
    func loadSampleSubjects() {
        
        let photo1 = UIImage(named: "math")!
        let question1_1 = Question("who invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"Newton and Leibnitz")
        let question1_2 = Question("who did not invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"Descartes")
        questions1 += [question1_1,question1_2]
        let subject1 = Subject("Math", "Rahhhhh!", photo1, questions1)
        
        
        let photo2 = UIImage(named: "science")!
        let question2_1 = Question("who invented gramophone?",["","Descartes","Leibnitz","Newton and Leibnitz"],"Newton and Leibnitz")
        let question2_2 = Question("who did not invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"Descartes")
        questions2 += [question2_1,question2_2]
        let subject2 = Subject("Science", "Wowwww!", photo2, questions2)
        
        let photo3 = UIImage(named: "marvel")!
        let question3_1 = Question("who is the author of ?",["Newton","","Leibnitz","Newton and Leibnitz"],"Newton and Leibnitz")
        let question3_2 = Question("who did not invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"Descartes")
        questions3 += [question3_1,question3_2]
        let subject3 = Subject("Marvel", "Yeahhhhh!", photo3, questions3)
        
        subjects += [subject1,subject2,subject3]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load the sample data.
        loadSampleSubjects()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == questionSegueIdentifier,
            let destination = segue.destination as? questionViewController,
            let subjectIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.questions = subjects[subjectIndex].questions
        }

    }


    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "subjectTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! subjectTableViewCell
        
        // Fetches the appropriate subject for the data source layout.
        let subject = subjects[indexPath.row]
        
        cell.titleLabel.text = subject.subjectTitle
        cell.iconImageView.image = subject.subjectIcon
        cell.descriptionLabelView.text = subject.subjectDescription
        
        return cell
    }
    

    //alert for settings
    @IBAction func alert(_ sender: AnyObject) {
        
        let alertController:UIAlertController = {
            return UIAlertController(title: "Settings", message: "Settings goes here", preferredStyle: UIAlertControllerStyle.alert)
        }()
        
        let okAlert:UIAlertAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in NSLog("You pressed button OK")}
        
        alertController.addAction(okAlert)
        
        self.present(alertController, animated: true, completion: nil);
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

