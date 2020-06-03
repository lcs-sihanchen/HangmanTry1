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
    var wordInProgress = "--------"
    var specificPath: String?
    var allWords = [String]()
    var guessedLetters = [String]()
    var correctAnswer: String!
    
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
        actualSolution.text = "--------"
        actualSolution.font = UIFont.systemFont(ofSize: 50)
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
        
        
        
        
        
        
        view.addSubview(hangmanImage)
        
        // MARK: Layout Constraints
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
            submit.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor, constant: 30),
            submit.widthAnchor.constraint(equalToConstant: 50),
            submit.heightAnchor.constraint(equalToConstant: 15),
            
            clear.widthAnchor.constraint(equalToConstant: 50),
            clear.heightAnchor.constraint(equalToConstant: 15),
            clear.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 15),
            clear.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor, constant: -35),
            
            actualSolution.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 15),
            actualSolution.widthAnchor.constraint(equalTo: currentAnswer.widthAnchor),
            actualSolution.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
            
            
            
            
            
            
            
        ])
        
        
        
        // Trigger submitTapped method when submit button is tapped (same with the clear button below)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
        
        
    }
    
    
    
    // Load image and text (levels)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Load start.txt
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startwords = try? String(contentsOf: startWordsURL) {
                allWords = startwords.components(separatedBy: "\n")
            }
        }
        loadLevel()
        // Find the path of the file
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("Hangman") {
                pictureSources.append(item)
            }
        }
        // Sort by numbers for each stage of Hangman
        pictureSources.sort()
        
        hangmanImage.image = UIImage(named: pictureSources[0])
        
        
        
        
        
    }
    
    
    @objc func submitTapped(_ sender: UIButton) {
        
        
        
        
        // Eliminate empty input
        guard let playerAnswer = currentAnswer.text, currentAnswer.text != "" , currentAnswer.text?.count == 1 || currentAnswer.text?.count == 8 else {
            // Alert Here
            let alert = UIAlertController(title: "Wrong Input", message: "Please type a single letter or the full answer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        // Eliminate int input
        for n in 0...9{
            if playerAnswer.hasPrefix("\(n)") == true {
                let ac = UIAlertController(title: "Wrong Input", message: "Please type a letter or the full answer.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(ac, animated: true)
            }
            
        }
        // Lowercased answer
        let playerGuessLowercased = playerAnswer.lowercased()
        
        // If the player gets the answer in one guess
        if playerGuessLowercased == correctAnswer {
            wordInProgress = playerGuessLowercased
            actualSolution.text = wordInProgress
            let ac = UIAlertController(title: "Congratulations", message: "You can move on to the next level!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                // call loadLevel() when player clicks continue
                self.loadLevel()
                self.currentAnswer.text = ""
                self.actualSolution.text = "--------"
                self.wordInProgress = "--------"
            }))
            present(ac, animated: true)
            
        // If the player guess a letter
        } else if correctAnswer.contains(playerGuessLowercased) == true && playerGuessLowercased.count == 1 {
            
            
            
            
            let arrayForWord = Array(correctAnswer)
            
            for x in 0...7 {
                
                if arrayForWord[x] == Character(playerGuessLowercased) {
                    wordInProgress = replaceSingleLetter(from: wordInProgress, target: "-", with: Character(playerGuessLowercased), index: x)
                }
                
                
            }
            
            
            actualSolution.text = wordInProgress
            
            if wordInProgress == correctAnswer {
                let ac = UIAlertController(title: "Congratulations", message: "You can move on to the next level!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                    self.loadLevel()
                    self.currentAnswer.text = ""
                    self.actualSolution.text = "--------"
                    self.wordInProgress = "--------"
                }))
                present(ac, animated: true)
                
                
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    @objc func clearTapped(_ sender: UIButton) {
        
    }
    
    @objc func loadLevel() {
        let randomNumber = Int.random(in: 0..<allWords.count - 1)
        correctAnswer = allWords[randomNumber]
        print(correctAnswer!)
    }
    
    
    func replaceSingleLetter(from originalWord: String, target: Character, with replacement: Character, index: Int) -> String {
        var word = Array(originalWord)
        
        
        
        if word[index] == target {
            word[index] = replacement
        }
        
        let newWord = String(word)
        return newWord
    }
}

