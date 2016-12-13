//
//  subjectTableViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/3.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit
import Foundation



class subjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: Properties
    
    
    let questionSegueIdentifier = "showQuestionSegue"
    
    @IBOutlet weak var subjectCell: subjectTableViewCell!
    // MARK: - Navigation
    
    // example from http://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
    
    var quizes = [Quiz]()
    var tempQuiz = Quiz("","",nil,[])
    var tempQuestions = [Question]()
    var newestQuizes = [Quiz]()
    var questions1 = [Question]()
    var questions2 = [Question]()
    var questions3 = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkConnectivity(){
            loadQuizesFromJson()
        }else{
            loadLocalQuizes()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func loadSampleQuizes() {
        //clear cache and out-dated data
        quizes = [Quiz]()
        questions1 = [Question]()
        questions2 = [Question]()
        questions3 = [Question]()
        
        let photo1 = UIImage(named: "math")!
        let question1_1 = Question("who invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"4")
        let question1_2 = Question("who did not invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"2")
        questions1 += [question1_1,question1_2]
        let quiz1 = Quiz("Math", "Rahhhhh!", photo1, questions1)
        
        
        let photo2 = UIImage(named: "science")!
        let question2_1 = Question("who invented gramophone?",["Edison","Descartes","Leibnitz","Newton and Leibnitz"],"1")
        let question2_2 = Question("who discovered electromagnetic induction?",["Ferrari","Faraday","Lorentz","Ampere"],"2")
        questions2 += [question2_1,question2_2]
        let quiz2 = Quiz("Science", "Wowwww!", photo2, questions2)
        
        let photo3 = UIImage(named: "marvel")!
        let question3_1 = Question("who is the author of Spider-man?",["Stan Lee","Steve Ditko","Stan Lee and Steve Ditko","Peter Parker"],"3")
        questions3 += [question3_1]
        let quiz3 = Quiz("Marvel", "Yeahhhhh!", photo3, questions3)
        
        quizes += [quiz1,quiz2,quiz3]
        do_table_refresh()
    }
    
    public func loadLocalQuizes(){
        //need to create file to store the data and then retrieve it
        if newestQuizes.count > 0{
            quizes = newestQuizes
        } else{
            loadSampleQuizes()
        }
    }
    
    //load data
    public func loadQuizesFromJson(){
        // clear old data before load new data
        quizes = [Quiz]()
        let photo3 = UIImage(named: "math")!
        let photo1 = UIImage(named: "science")!
        let photo2 = UIImage(named: "marvel")!
        let photos = [photo1,photo2,photo3]
        var i=0
        let requestURL: NSURL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                print("downloaded successfully.")
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    if let jsonQuizes = json as? [[String:AnyObject]]{
                        self.tempQuiz = Quiz("","",nil,[])
                        for jsonQuiz in jsonQuizes {
                            if let title = jsonQuiz["title"] as? String {
                                if let desc = jsonQuiz["desc"] as? String{
                                    if let questions = jsonQuiz["questions"] as? [[String:AnyObject]]{
                                        self.tempQuestions = [Question]()
                                        for question in questions{
                                            if let text = question["text"] as? String{
                                                if let answer = question["answer"] as? String{
                                                    if let answers = question["answers"] as? [String]{
                                                        var tempQuestion = Question(text,answers,answer)
                                                        self.tempQuestions.append(tempQuestion)
                                                        tempQuestion = Question("",[],"")
                                                    }
                                                }
                                            }
                                        }
                                        self.tempQuiz = Quiz("","",nil,[])
                                        self.tempQuiz = Quiz(title,desc,photos[i],self.tempQuestions)
                                        i += 1
                                        self.quizes.append(self.tempQuiz)
                                        print("add one quiz")
                                        self.do_table_refresh()
                                    }
                                }
                            }
                        }
                    }
                }catch {
                    print("Error with Json: \(error)")
                }
                
            }
        }
        task.resume()
        newestQuizes = quizes
    }
    
    
    
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            print("refreshed")
            return
        })
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "questionSegueIdentifier",
            let destination = segue.destination as? questionViewController,
            let quizIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.questions = quizes[quizIndex].questions
        }
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "subjectTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! subjectTableViewCell
        
        // Fetches the appropriate subject for the data source layout.
        let quiz = quizes[indexPath.row]
        
        cell.titleLabel.text = quiz.title
        cell.iconImageView.image = quiz.icon
        cell.descriptionLabelView.text = quiz.desc
        
        return cell
    }
    
    
    //alert for settings
    //    @IBAction func alert(_ sender: AnyObject) {
    //
    //        let alertController:UIAlertController = {
    //            return UIAlertController(title: "Settings", message: "Settings goes here", preferredStyle: UIAlertControllerStyle.alert)
    //        }()
    //
    //        let okAlert:UIAlertAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in NSLog("You pressed button OK")}
    //
    //        alertController.addAction(okAlert)
    //
    //        self.present(alertController, animated: true, completion: nil);
    //    }
    
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

