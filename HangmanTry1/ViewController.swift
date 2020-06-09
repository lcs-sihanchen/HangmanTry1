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
    var lives = 5 {
        didSet {
            livesLabel.text = "Lives: \(lives)"
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var hangmanImage: UIImageView!
    var pictureSources = [String]()
    var actualSolution: UILabel!
    var wordInProgress = "--------"
    var specificPath: String?
    var allWords = [String]()
    var guessedLetters = [Character]()
    var guessedLettersLabel: UITextView!
    var correctAnswer: String!
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // MARK:Labels
        livesLabel = UILabel()
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.textAlignment = .left
        livesLabel.text = "Lives: \(lives)"
        livesLabel.backgroundColor = .red
        livesLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(livesLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(scoreLabel)
        
        actualSolution = UILabel()
        actualSolution.translatesAutoresizingMaskIntoConstraints = false
        actualSolution.textAlignment = .center
        actualSolution.text = "--------"
        actualSolution.adjustsFontSizeToFitWidth = true
        actualSolution.font = UIFont(name: "Courier", size: 50)
        view.addSubview(actualSolution)
        
        guessedLettersLabel = UITextView()
        guessedLettersLabel.isUserInteractionEnabled = false
        guessedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        guessedLettersLabel.textAlignment = .left
        guessedLettersLabel.text = "The letter you have guessed: \n"
//        guessedLettersLabel.adjustsFontForContentSizeCategory = true
        guessedLettersLabel.font = UIFont(name: "Courier", size: 24)
        view.addSubview(guessedLettersLabel)
        
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
        
        let restart = UIButton(type: .system)
        restart.setTitle("Restart", for: .normal)
        restart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(restart)
        
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
            
            hangmanImage.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            hangmanImage.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.3),
            hangmanImage.topAnchor.constraint(equalTo: livesLabel.bottomAnchor, constant: 30),
            hangmanImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            hangmanImage.trailingAnchor.constraint(equalTo: guessedLettersLabel.leadingAnchor),
            
            currentAnswer.topAnchor.constraint(equalTo: hangmanImage.bottomAnchor, constant: 40),
            currentAnswer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 15),
            submit.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor, constant: 30),
            submit.widthAnchor.constraint(equalToConstant: 50),
            submit.heightAnchor.constraint(equalToConstant: 15),
            
            restart.widthAnchor.constraint(equalToConstant: 50),
            restart.heightAnchor.constraint(equalToConstant: 15),
            restart.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 15),
            restart.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor, constant: -35),
            
            actualSolution.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 15),
            actualSolution.widthAnchor.constraint(equalTo: currentAnswer.widthAnchor),
            actualSolution.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            guessedLettersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4),
            guessedLettersLabel.leadingAnchor.constraint(equalTo: hangmanImage.trailingAnchor),
            guessedLettersLabel.topAnchor.constraint(equalTo: livesLabel.bottomAnchor, constant: 30),
            guessedLettersLabel.heightAnchor.constraint(equalTo: hangmanImage.heightAnchor)
            
            
            
            
            
            
            
        ])
        
        guessedLettersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        // Trigger submitTapped method when submit button is tapped (same with the clear button below)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        restart.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        
        
        
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
        
        score = 0
        lives = 5
        
        
        
    }
    
    
    @objc func submitTapped(_ sender: UIButton) {
        
        
        
        
        // Eliminate empty and few letters input
        guard let playerAnswer = currentAnswer.text, currentAnswer.text != "" , currentAnswer.text?.count == 1 || currentAnswer.text?.count == 8 else {
            // Alert Here
            let alert = UIAlertController(title: "Wrong Input", message: "Please type a single letter or the full answer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                self.currentAnswer.text = ""
            }))
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
        
        if guessedLetters.contains(Character(playerGuessLowercased)) == true {
            let ac = UIAlertController(title: "You have tried this!", message: "Try another one!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
            present(ac, animated: true)
            self.currentAnswer.text = ""
        }
            // If the player gets the answer in one guess
        else if playerGuessLowercased == correctAnswer {
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
            
            // If the player guess a letter right
        } else if correctAnswer.contains(playerGuessLowercased) == true && playerGuessLowercased.count == 1 {
            
            
            
            
            let arrayForWord = Array(correctAnswer)
            
            for x in 0...7 {
                
                if arrayForWord[x] == Character(playerGuessLowercased) {
                    wordInProgress = replaceSingleLetter(from: wordInProgress, target: "-", with: Character(playerGuessLowercased), index: x)
                }
                
                
            }
            
            guessedLetters.append(Character(playerGuessLowercased))
            
            if guessedLetters.isEmpty == false {
                var stringToDisplay: String = "The letter you have guessed: \n"
                for character in guessedLetters {
                    stringToDisplay = stringToDisplay + String(character) + ", "
                }
                guessedLettersLabel.text = stringToDisplay
            }
            
            
            
            
            actualSolution.text = wordInProgress
            self.currentAnswer.text = ""
            score += 1
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
            // If the player guess a letter wrong
        else if correctAnswer.contains(playerGuessLowercased) == false && playerGuessLowercased.count == 1 {
            
            lives -= 1
            score -= 1
            let ac = UIAlertController(title: "Not even close!", message: "Please try again. Lives left: \(lives)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
            present(ac, animated: true)
            self.currentAnswer.text = ""
            
            
            guessedLetters.append(Character(playerGuessLowercased))
            if guessedLetters.isEmpty == false {
                var stringToDisplay: String = "The letter you have guessed: \n"
                for character in guessedLetters {
                    stringToDisplay = stringToDisplay + String(character) + ", "
                }
                guessedLettersLabel.text = stringToDisplay
            }
            
            
            // If the player does not get the full answer right
        } else {
            
            lives -= 1
            score -= 1
            let ac = UIAlertController(title: "Try Again!", message: "You will get the word on next try!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .cancel))
            present(ac, animated: true)
            self.currentAnswer.text = ""
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    // load a new word
    @objc func restartTapped(_ sender: UIButton) {
        
        self.loadLevel()
        self.currentAnswer.text = ""
        self.actualSolution.text = "--------"
        self.wordInProgress = "--------"
    }
    
    @objc func loadLevel() {
        // get a random word from the database
        let randomNumber = Int.random(in: 0..<allWords.count - 1)
        correctAnswer = allWords[randomNumber]
        print(correctAnswer!)
        guessedLetters.removeAll()
        lives = 5
        guessedLettersLabel.text = "The letter you have guessed: \n"
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

