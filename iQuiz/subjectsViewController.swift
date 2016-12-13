//
//  subjectTableViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/3.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit
import Foundation
import CoreData



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
    var questions1 = [Question]()
    var questions2 = [Question]()
    var questions3 = [Question]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkConnectivity(){
            loadQuizesFromJson()
        }else{
            loadLocalQuizes()
            tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let alertController:UIAlertController = {
            return UIAlertController(title: "Settings", message: "Settings goes here", preferredStyle: UIAlertControllerStyle.alert)
        }()
        
        let okAlert:UIAlertAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in NSLog("You pressed button OK")}
        
        alertController.addAction(okAlert)
        
        self.present(alertController, animated: true, completion: nil);

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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    public func loadLocalQuizes(){
        //clear history before load new data

        
        var tempQuizes:[Quiz] = []
        var tempQuiz = Quiz("","",nil,[])
        var tempTitle: String = ""
        var tempIconName: String = ""
        var tempDesc: String = ""
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<AAALocalQuiz> = AAALocalQuiz.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for quiz in searchResults as [NSManagedObject] {
                            tempTitle = quiz.value(forKey: "quizTitle") as! String
                            tempIconName = quiz.value(forKey: "iconName") as! String
                            let tempIcon = UIImage(named: tempIconName)!
                            tempDesc = quiz.value(forKey: "desc") as! String
                            tempQuiz = Quiz(tempTitle,tempDesc,tempIcon,[])
                            tempQuizes.append(tempQuiz)
                            print("count: ",tempQuizes.count)
                            tableView.reloadData()
            }
            if tempQuizes.count > 0{
                quizes = tempQuizes
            }
        } catch {
            print("Error with request: \(error)")
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
        let photoNames:[String] = ["science","marvel","math"]
        var i=0
        self.deleteAllData(entity: "LocalQuiz")
        
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
                                        //store quiz to local storage
                                        let photoName = photoNames[i]
                                        self.storeQuizToLocal(title,desc,photoName)
                                        
                                        //store in memory
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
    }
    
    func storeQuizToLocal(_ title:String,_ desc:String,_ iconName:String){
        
        
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //let entity = NSEntityDescription.entity(forEntityName: "LocalQuiz", in: context)
        //let localQuiz = NSManagedObject(entity: entity!, insertInto: context)
        let localQuiz = NSEntityDescription.insertNewObject(forEntityName: "LocalQuiz", into: context) as! AAALocalQuiz
        
                localQuiz.setValue(title, forKey: "quizTitle")
                localQuiz.setValue(desc,forKey:"desc")
                localQuiz.setValue(iconName, forKey: "iconName")
        
        do {
            try context.save()
            print("appended!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
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

