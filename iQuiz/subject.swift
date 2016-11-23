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

var result: Bool = false
public func checkConnectivity() -> Bool{
    //declare this property where it won't go out of scope relative to your listener
    let reachability = Reachability()!

    reachability.whenReachable = { reachability in
        // this is called on a background thread, but UI updates must
        // be on the main thread, like this:
        DispatchQueue.main.async(execute: {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        )
    }
    reachability.whenUnreachable = { reachability in
        // this is called on a background thread, but UI updates must
        // be on the main thread, like this:
        DispatchQueue.main.async(execute:  {
            print("No Internet connection, not reachable")
            result = false
        }
        )
    }
    
    do {
        try reachability.startNotifier()
    } catch {
        print("Unable to start notifier")
    }
    
    if reachability.isReachable{
        result = true
    } else{
        result = false
    }
    
    return result
}



