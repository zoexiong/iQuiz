//
//  ViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/3.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit

class Question{
    var questionTitle: String
    var options: [String]
    var answer: String
    
    init(_ questionTitle:String, _ options:[String], _ answer:String){
        self.questionTitle = questionTitle
        self.options = options
        self.answer = answer
    }
}


class Quiz {
    var title: String
    var desc: String
    var icon: UIImage?
    var questions: [Question]
    
    init(_ title: String, _ desc: String, _ icon: UIImage?, _ questions:[Question]){
        self.title = title
        self.icon = icon
        self.desc = desc
        self.questions = questions
    }
}






