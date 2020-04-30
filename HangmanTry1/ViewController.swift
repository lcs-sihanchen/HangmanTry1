//
//  ViewController.swift
//  HangmanTry1
//
//  Created by Chen, Sihan on 2020-04-18.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: Properties
    
    var livesLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswer: UITextField!
    var lives = 0
    var score = 0
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var hangmanImage: UIImageView!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // MARK:Labels
        livesLabel = UILabel()
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.textAlignment = .left
        livesLabel.text = "Lives: 5"
        view.addSubview(livesLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        // MARK: Buttons
        let submit = UIButton(type: .system)
        submit.setTitle("Submit", for: .normal)
        submit.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.setTitle("Clear", for: .normal)
        clear.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

