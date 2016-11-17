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

var subjects = [Subject]()
var questions1 = [Question]()
var questions2 = [Question]()
var questions3 = [Question]()


public func loadSampleSubjects() {
    //clear cache and out-dated data
    subjects = [Subject]()
    questions1 = [Question]()
    questions2 = [Question]()
    questions3 = [Question]()
    
    let photo1 = UIImage(named: "math")!
    let question1_1 = Question("who invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"Newton and Leibnitz")
    let question1_2 = Question("who did not invented caculous?",["Newton","Descartes","Leibnitz","Newton and Leibnitz"],"Descartes")
    questions1 += [question1_1,question1_2]
    let subject1 = Subject("Math", "Rahhhhh!", photo1, questions1)
    
    
    let photo2 = UIImage(named: "science")!
    let question2_1 = Question("who invented gramophone?",["Edison","Descartes","Leibnitz","Newton and Leibnitz"],"Edison")
    let question2_2 = Question("who discovered electromagnetic induction?",["Ferrari","Faraday","Lorentz","Ampere"],"Faraday")
    questions2 += [question2_1,question2_2]
    let subject2 = Subject("Science", "Wowwww!", photo2, questions2)
    
    let photo3 = UIImage(named: "marvel")!
    let question3_1 = Question("who is the author of Spider-man?",["Stan Lee","Steve Ditko","Stan Lee and Steve Ditko","Peter Parker"],"Stan Lee and Steve Ditko")
    questions3 += [question3_1]
    let subject3 = Subject("Marvel", "Yeahhhhh!", photo3, questions3)
    
    subjects += [subject1,subject2,subject3]
}

public func loadSubjectsFromJson(){
    
}
