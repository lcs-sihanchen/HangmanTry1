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
    var pictureSources = [String]()
    var actualSolution: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // MARK:Labels
        livesLabel = UILabel()
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.textAlignment = .left
        livesLabel.text = "Lives: 5"
        livesLabel.backgroundColor = .red
        livesLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(livesLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(scoreLabel)
        
        actualSolution = UILabel()
        actualSolution.translatesAutoresizingMaskIntoConstraints = false
        actualSolution.textAlignment = .left
        actualSolution.text = "       "
        actualSolution.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(actualSolution)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 24)
        currentAnswer.isUserInteractionEnabled = true
        currentAnswer.placeholder = "Answers here"
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
        
        scoreLabel.backgroundColor = .blue
        actualSolution.backgroundColor = .gray
        // MARK: Image View
        hangmanImage = UIImageView()
        hangmanImage.translatesAutoresizingMaskIntoConstraints = false
        hangmanImage.isUserInteractionEnabled = false
        let imageToLoad = "HangmanImage1"
        hangmanImage.image = UIImage(named: imageToLoad)
        
        view.addSubview(hangmanImage)
        hangmanImage.backgroundColor = .cyan
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
        
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            livesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            livesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
            hangmanImage.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            hangmanImage.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),
            hangmanImage.topAnchor.constraint(equalTo: livesLabel.bottomAnchor, constant: 30),
            hangmanImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            hangmanImage.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            currentAnswer.topAnchor.constraint(equalTo: hangmanImage.bottomAnchor, constant: 40),
            currentAnswer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 15),
            submit.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            actualSolution.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 15),
            actualSolution.widthAnchor.constraint(equalTo: currentAnswer.widthAnchor),
            actualSolution.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
           
            
        
        
        
        
        
        ])
        
        
        
        
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
        
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

