//
//  answerViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/16.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit

class answerViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yourAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var tickLabel: UILabel!
    
    var answerIndex = -1
    var questionIndex = 0
    var question = Question("",[],"")
    var questionsCount = 0
    var questions = [Question]()
    public var correctAnswer = 0
    public var nextButtonHideStatus: Bool = false
    public var finishedButtonHideStatus: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question.questionTitle
        yourAnswerLabel.text = question.options[answerIndex]
        correctAnswerLabel.text = question.answer
        correctAnswerLabel.textColor = UIColor.green
        if question.answer == question.options[answerIndex]{
            tickLabel.text = "✅"
            yourAnswerLabel.textColor = UIColor.green
            correctAnswer += 1
        }else{
            tickLabel.text = "❌"
            yourAnswerLabel.textColor = UIColor.red
        }
        
        if questionsCount == 1{
            nextButton.isHidden = true
            finishButton.isHidden = false
        }else{
        nextButton.isHidden = nextButtonHideStatus
        finishButton.isHidden = finishedButtonHideStatus
        }
    
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "nextQuestionSegue",
            let destination = segue.destination as? questionViewController
        {
            destination.questionIndex = questionIndex
            destination.questions = questions
            destination.nextButtonHideStatus = nextButtonHideStatus
            destination.finishedButtonHideStatus = finishedButtonHideStatus
            destination.correctAnswer = correctAnswer
        }
        if  segue.identifier == "resultSegue",
            let destination = segue.destination as? resultViewController
        {
            destination.correctAnswer = correctAnswer
            destination.questionsCount = questionsCount
        }

    }

    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBAction func nextButton(_ sender: AnyObject) {
 //      nextButton.removeFromSuperview()
        questionIndex += 1
        if questionIndex < questionsCount-1{
            nextButtonHideStatus = false
            finishedButtonHideStatus = true
        }else if questionIndex == questionsCount-1{
            nextButtonHideStatus = true
            finishedButtonHideStatus = false
        }
    }
    
    @IBAction func finishButton(_ sender: AnyObject) {
        questionIndex = 0
        nextButton.isHidden = false
        finishButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
