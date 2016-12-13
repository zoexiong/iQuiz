//
//  questionViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/15.
//  Copyright © 2016年 Just. All rights reserved.
//

////////////
//Todo: Extra credits
//and error handling when user did not select any answer option
////////////

import UIKit

class questionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var questions = [Question]()
    var questionIndex = 0
    var correctAnswerCount = 0
    public var nextButtonHideStatus: Bool = false
    public var finishedButtonHideStatus: Bool = true
    
    @IBOutlet weak var submitButton: UIButton!
    
//    var submitButton.isEnabled = false
    
    override func viewWillAppear(_ animated: Bool) {
        print(questions.count)
    questionLabel.text = questions[questionIndex].questionTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //disable submit button when loaded to prevent user from press it without choose answer
        submitButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[questionIndex].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "optionTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! optionTableViewCell
        
        // Fetches the appropriate subject for the data source layout.
        let options = questions[questionIndex].options
        
        cell.optionLabel?.text = options[indexPath.row]
        return cell
    }
    
    //when user choose an answer, enable the submit button
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        submitButton.isEnabled = true
    }
    
    //when deselect an answer, disable the submit button
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        submitButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if  segue.identifier == "questionToAnswerSegue",
            let destination = segue.destination as? answerViewController,
            let answerIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.answerIndex = answerIndex
            destination.question = questions[questionIndex]
            destination.questionIndex = questionIndex
            destination.questionsCount = questions.count
            destination.questions = questions
            destination.nextButtonHideStatus = nextButtonHideStatus
            destination.finishedButtonHideStatus = finishedButtonHideStatus
            destination.correctAnswerCount = correctAnswerCount
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
