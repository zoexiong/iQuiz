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

var quizes = [Quiz]()
var tempQuiz = Quiz("","",nil,[])
var tempQuestions = [Question]()

    //load data
    public func loadSubjectsFromJson(){
        // clear old data before load new data
        quizes = [Quiz]()
        let requestURL: NSURL = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    if let jsonQuizes = json as? [[String:AnyObject]]{
                        tempQuiz = Quiz("","",nil,[])
                        for jsonQuiz in jsonQuizes {
                            if let title = jsonQuiz["title"] as? String {
                                if let desc = jsonQuiz["desc"] as? String{
                                    if let questions = jsonQuiz["questions"] as? [[String:AnyObject]]{
                                        tempQuestions = [Question]()
                                        for question in questions{
                                            if let text = question["text"] as? String{
                                                if let answer = question["answer"] as? String{
                                                    if let answers = question["answers"] as? [String]{
                                                        var tempQuestion = Question(text,answers,answer)
                                                        tempQuestions.append(tempQuestion)
                                                        tempQuestion = Question("",[],"")
                                                    }
                                                }
                                            }
                                        }
                                        tempQuiz = Quiz("","",nil,[])
                                        tempQuiz = Quiz(title,desc,nil,tempQuestions)
                                        quizes.append(tempQuiz)
                                        print("append once!")
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



