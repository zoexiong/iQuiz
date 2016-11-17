//
//  resultViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/16.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {

    var correctAnswer = 0
    var questionsCount = 0
    
    @IBOutlet weak var staticLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var outOfLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if correctAnswer == questionsCount {
            statusLabel.text = "Perfect"
        } else if correctAnswer == 0{
            statusLabel.text = "Not good..."
        } else if correctAnswer == questionsCount-1{
            statusLabel.text = "Almost!"
        } else{
            statusLabel.text = "not bad!"
        }
        staticLabel.text = "Your answered "+String(correctAnswer)+" questions correctly"
        // Do any additional setup after loading the view.
        outOfLabel.text = "out of "+String(questionsCount)+" questions!"
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