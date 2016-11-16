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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question.questionTitle
        yourAnswerLabel.text = question.options[answerIndex]
        correctAnswerLabel.text = question.answer
        correctAnswerLabel.textColor = UIColor.green
        if question.answer == question.options[answerIndex]{
            tickLabel.text = "✅"
            yourAnswerLabel.textColor = UIColor.green
        }else{
            tickLabel.text = "❌"
            yourAnswerLabel.textColor = UIColor.red
        }
    
        // Do any additional setup after loading the view.
    }

    @IBAction func nextButton(_ sender: AnyObject) {
        questionIndex += 1
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
