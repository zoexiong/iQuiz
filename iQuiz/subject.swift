//
//  ViewController.swift
//  iQuiz
//
//  Created by Just on 16/11/3.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit

class Subject {
    var subjectTitle : String
    var subjectDescription : String
    var subjectIcon : UIImage?
    
    init(_ subjectTitle:String, _ subjectDescription:String, _ subjectIcon:UIImage?){
        self.subjectTitle = subjectTitle
        self.subjectIcon = subjectIcon
        self.subjectDescription = subjectDescription
    }
}

