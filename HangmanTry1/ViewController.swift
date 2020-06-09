//
//  ViewController.swift
//  HangmanTry1
//
//  Created by Chen, Sihan on 2020-04-18.
//  Copyright © 2020 Chen, Sihan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    // MARK: Properties
    
    var livesLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswer: UITextField!
    // Whenever the value of "lives" changed, the scoreLabel text changes as well
    var lives = 5 {
        didSet {
            livesLabel.text = "Lives: \(lives)"
        }
    }
    // Whenever the value of "score" changed, the scoreLabel text changes as well
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
   
    // This property is used to store the hangman image
    var hangmanImage: UIImageView!
    // This property contains all the names of the pictures in the content
    var pictureSources = [String]()
    // This label shows the player their progress
    var actualSolution: UILabel!
    // This is the word in progress(being guessed)
    var wordInProgress = "--------"
    
    // This array stores all the word from the txt file
    var allWords = [String]()
    // This array stored all the letters that have been guessed
    var guessedLetters = [Character]()
    // This textview is used to show player what letters they have guessed
    var guessedLettersLabel: UITextView!
    // Correct Answer
    var correctAnswer: String!
    // Used for speaking the word when the player gets the right answer
    let synthesizer = AVSpeechSynthesizer()
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // MARK:Labels
        // Add these labels to the view and give them some initial properties
        livesLabel = UILabel()
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.textAlignment = .left
        livesLabel.text = "Lives: \(lives)"
//        livesLabel.backgroundColor = .red
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
        // Here are some buttons, when clicked it will trigger some methods
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
        
//        scoreLabel.backgroundColor = .blue
//        actualSolution.backgroundColor = .gray
        livesLabel.textColor = .red
        
        // MARK: Image View
        hangmanImage = UIImageView()
        hangmanImage.translatesAutoresizingMaskIntoConstraints = false
        hangmanImage.isUserInteractionEnabled = false
        
        
        
        
        
        
        view.addSubview(hangmanImage)
        
        // MARK: Layout Constraints
        // Use code to give each piece of element some kind of constraints so it will be placed in the position they are and do not overlap
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
            
            livesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
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
        // When submit is tapped, call submitTapped()
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        // When restart is tapped, call restartTapped()
        restart.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        
        
        
    }
    
    // View will show and hide the navigation bar when tapped
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
        // Load the first word
        loadLevel()
        
        
        // Sort by numbers for each stage of Hangman
        pictureSources.sort()
        
        // Add a share button in the navigation bar
        let theRightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = theRightBarButtonItem
        navigationController?.isNavigationBarHidden = false
        
        // Set the initial image for hangman
        hangmanImage.image = UIImage(named: pictureSources[0])
        
        // Set the initial score and lives
        score = 0
        lives = 5
        
        
        
        
        
    }
    
    // When share button is tapped...
    @objc func shareTapped() {
        // Convert image into jpeg data, with a specified quality of 0.8
        
        guard let image = hangmanImage.image?.jpegData(compressionQuality: 0.8) else {
            
            // If there is no image, print this:
            print("No image found")
            return
                
        }
        
        let text = correctAnswer!
        let vc = UIActivityViewController(activityItems: [image] + [text], applicationActivities: [])
        
        // This line of code only works on Ipad, if it's iphone, it will be ignored
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        // Present so we can see it on the screen
        present(vc, animated: true)
    }
    
    // When submit button is tapped...
    @objc func submitTapped(_ sender: UIButton) {
        
        // Eliminate empty and few letters input
        // Can't be empty, has to be string, should only contain 1 or 8 letters
        guard let playerAnswer = currentAnswer.text, currentAnswer.text != "" , currentAnswer.text?.count == 1 || currentAnswer.text?.count == 8 else {
            // Show an alert of wrong input
            sendAlertMessage(title: "Wrong Input", message: "Please type a single letter or the full answer.", action: UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                self.currentAnswer.text = ""
            }))
            
            return
        }
        
        // Eliminate int input
        for n in 0...9{
            // if they have one of the numbers, then return
            if playerAnswer.hasPrefix("\(n)") == true {
                
                // Alert message here
                sendAlertMessage(title: "Wrong Input", message: "Please type a letter or the full answer.", action: UIAlertAction(title: "Cancel", style: .cancel))
                
                self.currentAnswer.text = ""
                return
            }
            
        }
        
        
        // Lowercased answer
        let playerGuessLowercased = playerAnswer.lowercased()
        
        // If user submits a single letter and the letter is already in the guessed letters array, then return
        if playerGuessLowercased.count == 1 && guessedLetters.contains(Character(playerGuessLowercased)) == true {
            
            // Alert message here
            sendAlertMessage(title: "You have tried this!", message: "Try another one!", action: UIAlertAction(title: "Continue", style: .cancel))
            
            self.currentAnswer.text = ""
        }
            
            // If the player gets the answer in one guess
        else if playerGuessLowercased == correctAnswer {
            let occurenceOfHyphens = wordInProgress.components(separatedBy: "-")
            // For every letter that is guessed in a whole answer, score doubles
            score += (occurenceOfHyphens.count - 1) * 2
            // Speak the word when the user gets the correct answer
            let wordToSpeak = "\(correctAnswer!)"
            let utterance = AVSpeechUtterance(string: wordToSpeak)
            synthesizer.speak(utterance)
            
            // Set the label to the correct answer so people can see
            wordInProgress = playerGuessLowercased
            actualSolution.text = wordInProgress
            
            // Alert for going to the next level
            sendAlertMessage(title: "Congratulations", message: "You can move on to the next level!", action: UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                // call loadLevel() when player clicks continue
                self.loadLevel()
            }))
            
            // If the player guess a letter right
        } else if correctAnswer.contains(playerGuessLowercased) == true && playerGuessLowercased.count == 1 {
            
            
            
            // Make the word an array of letters
            let arrayForWord = Array(correctAnswer)
            // In these eight letters, each of them will compare to the correct answer, if they are the same, replace the "-" with the character
            for x in 0...7 {
                
                if arrayForWord[x] == Character(playerGuessLowercased) {
                    wordInProgress = replaceSingleLetter(from: wordInProgress, target: "-", with: Character(playerGuessLowercased), index: x)
                }
                
                
            }
            
            // Append the letter that the player just guessed to the guessed letters array
            guessedLetters.append(Character(playerGuessLowercased))
            
            // if the array is not empty, append the letter to the label that displays the guessed letters
            if guessedLetters.isEmpty == false {
                var stringToDisplay: String = "The letters you have guessed: \n"
                for character in guessedLetters {
                    stringToDisplay = stringToDisplay + String(character) + ", "
                }
                guessedLettersLabel.text = stringToDisplay
            }
            
            
            
            // Push wordInProgress on the screen
            actualSolution.text = wordInProgress
            // Delete everything in the textfield so user can guess another letter
            self.currentAnswer.text = ""
            // score +1 for getting 1 letter right
            score += 1
            // If this is the last letter and the player gets it correctly
            if wordInProgress == correctAnswer {
                // Speak the word
                let wordToSpeak = "\(correctAnswer!)"
                let utterance = AVSpeechUtterance(string: wordToSpeak)
                synthesizer.speak(utterance)
                
                // Alert for going to the next level
                sendAlertMessage(title: "Congratulations", message: "You can move on to the next level!", action: UIAlertAction(title: "Continue", style: .default, handler: { (action) in
                    self.loadLevel()
                }))
               
                
                
            }
            
        }
            // If the player guess a single letter wrong
        else if correctAnswer.contains(playerGuessLowercased) == false && playerGuessLowercased.count == 1 {
            // Minus 1 on lives and score
            lives -= 1
            score -= 1
            
            // When the lives run out, load another game
            if lives == 0 {
                sendAlertMessage(title: "Your lives run out!", message: "The correct answer is \(correctAnswer!)!", action: UIAlertAction(title: "Try another word!", style: .default, handler: { (action) in
                    self.loadLevel()
                }))
                
                
            // If not, give away an alert for -1 life
            } else {
                sendAlertMessage(title: "Not even close!", message: "Please try again. Lives left: \(lives)", action: UIAlertAction(title: "Continue", style: .cancel))
                self.currentAnswer.text = ""
                
            }
            
            // add the letter to the guessedLetters array and display it
            guessedLetters.append(Character(playerGuessLowercased))
            if guessedLetters.isEmpty == false {
                var stringToDisplay: String = "The letters you have guessed: \n"
                for character in guessedLetters {
                    stringToDisplay = stringToDisplay + String(character) + ", "
                }
                guessedLettersLabel.text = stringToDisplay
            
            // Based on how many lives have been left, switch image
                switch lives {
                case 5:
                    hangmanImage.image = UIImage(named: pictureSources[0])
                case 4:
                    hangmanImage.image = UIImage(named: pictureSources[1])
                case 3:
                    hangmanImage.image = UIImage(named: pictureSources[2])
                case 2:
                    hangmanImage.image = UIImage(named: pictureSources[3])
                case 1:
                    hangmanImage.image = UIImage(named: pictureSources[4])
                case 0:
                    hangmanImage.image = UIImage(named: pictureSources[5])
                    
                
                default:
                    hangmanImage.image = UIImage(named: pictureSources[6])
                }
                
            }
            
            
            // If the player does not get the full answer correctly
        } else {
            // Minus 1 on lives and score
            lives -= 1
            score -= 1
            // When lives run out, load a new level
            if lives == 0 {
                sendAlertMessage(title: "Your lives run out!", message: "The correct answer is \(correctAnswer!)!", action: UIAlertAction(title: "Try another word!", style: .default, handler: { (action) in
                    self.loadLevel()
                    
                }))
                
            // If not, send a message of minus 1 life
            } else {
                sendAlertMessage(title: "Try Again!", message: "You will get the word on next try!", action: UIAlertAction(title: "Continue", style: .cancel))
            }
            
            // Reset the textfield
            self.currentAnswer.text = ""
            
            // Based on how many lives have been left, determine the stage of the hangman
            switch lives {
            case 5:
                hangmanImage.image = UIImage(named: pictureSources[0])
            case 4:
                hangmanImage.image = UIImage(named: pictureSources[1])
            case 3:
                hangmanImage.image = UIImage(named: pictureSources[2])
            case 2:
                hangmanImage.image = UIImage(named: pictureSources[3])
            case 1:
                hangmanImage.image = UIImage(named: pictureSources[4])
            case 0:
                hangmanImage.image = UIImage(named: pictureSources[5])
                
                
            default:
                hangmanImage.image = UIImage(named: pictureSources[6])
            }
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    // load a new word(manually)
    @objc func restartTapped(_ sender: UIButton) {
        
        self.loadLevel()
    }
    
    
    // load it when ever we need to start a new word
    @objc func loadLevel() {
        // get a random word from the database
        let randomNumber = Int.random(in: 0..<allWords.count - 1)
        correctAnswer = allWords[randomNumber]
        print(correctAnswer!)
        guessedLetters.removeAll()
        lives = 5
        guessedLettersLabel.text = "The letters you have guessed: \n"
        
        // Find the path of the file
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("Hangman") {
                pictureSources.append(item)
            }
        }
        hangmanImage.image = UIImage(named: pictureSources[0])
        currentAnswer.text = ""
        actualSolution.text = "--------"
        wordInProgress = "--------"
    }
    
// Replace a letter in the string with another letter
    func replaceSingleLetter(from originalWord: String, target: Character, with replacement: Character, index: Int) -> String {
        var word = Array(originalWord)
        
        
        
        if word[index] == target {
            word[index] = replacement
        }
        
        let newWord = String(word)
        return newWord
    }
    
    
    func sendAlertMessage(title: String, message: String, action: UIAlertAction) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(action)
        present(ac, animated: true)
        
    }
}

