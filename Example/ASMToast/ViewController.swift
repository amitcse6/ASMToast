//
//  ViewController.swift
//  ASMToast
//
//  Created by amitpstu1@gmail.com on 07/11/2020.
//  Copyright (c) 2020 amitpstu1@gmail.com. All rights reserved.
//

import UIKit
import ASMToast

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ASMToast.toastAlignment = .center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shortMessage(_ sender: Any) {
        ASMToast.show("Insert successfully!")
    }
    
    @IBAction func mediumMessage(_ sender: Any) {
        ASMToast.show("Authentication failed! please check your username or password.")
    }
    
    @IBAction func largeMessage(_ sender: Any) {
        ASMToast.show(getLargeText())
    }
}

extension ViewController {
    func getLargeText() -> String {
        return """
        Schieble became pregnant with Jobs in 1954, when she and Jandali spent the summer with his family in Homs, Syria. According to Jandali, Schieble deliberately did not involve him in the process: "without telling me, Joanne upped and left to move to San Francisco to have the baby without anyone knowing, including me."
        
        Schieble gave birth to Jobs on February 24, 1955, in San Francisco and chose an adoptive couple for him that was "Catholic, well-educated, and wealthy,"[13][page needed][14] but the couple later changed their mind.[13][page needed] Jobs was then placed with Paul and Clara Jobs, neither of whom had a college education, and Schieble refused to sign the adoption papers.[15] She then took the matter to court in an attempt to have her baby placed with a different family,[13][page needed] and only consented to releasing the baby to Paul and Clara after the couple pledged to pay for the boy's college education.
        
        When Steve Jobs was in high school, his mother Clara admitted to his girlfriend, Chrisann Brennan, that she "was too frightened to love [Steve] for the first six months of his life ... I was scared they were going to take him away from me. Even after we won the case, Steve was so difficult a child that by the time he was two I felt we had made a mistake. I wanted to return him."[13][page needed] When Chrisann shared his mother's comment with Steve, he stated that he was already aware,[13][page needed] and would later say he was deeply loved and indulged by Paul and Clara.[17][page needed] Many years later, Steve Jobs's wife Laurene also noted that "he felt he had been really blessed by having the two of them as parents."[17][page needed] Jobs would become upset when Paul and Clara were referred to as his "adoptive parents"; he regarded them as his parents "1,000%". With regard to his biological parents, Jobs referred to them as "my sperm and egg bank. That's not harsh, it's just the way it was, a sperm bank thing, nothing more."
        """
    }
}

