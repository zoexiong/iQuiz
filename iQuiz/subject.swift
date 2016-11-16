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

class Subject {
    var subjectTitle : String
    var subjectDescription : String
    var subjectIcon : UIImage?
    var questions: [Question]
    
    init(_ subjectTitle:String, _ subjectDescription:String, _ subjectIcon:UIImage?, _ questions:[Question]){
        self.subjectTitle = subjectTitle
        self.subjectIcon = subjectIcon
        self.subjectDescription = subjectDescription
        self.questions = questions
    }
}

