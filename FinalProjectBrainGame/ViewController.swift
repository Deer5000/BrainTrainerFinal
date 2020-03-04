//
//  GameViewController.swift
//  brainGame FinalViewController
//
//  Created by Khidr Brinkley on 3/3/20.
//  Copyright © 2020 Khidr Brinkley. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let potentialColors = ["blue", "red", "green", "orange", "yellow"]
    let potentialUIColors = [UIColor.blue, UIColor.red, UIColor.green, UIColor.orange, UIColor.yellow ]
      
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var textColorLabel: UILabel!
    @IBOutlet weak var answerIndicator: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var playAgainYesButton: UIButton!
    @IBOutlet weak var playAgainNoButton: UIButton!
    
    //Timer
    var timer = Timer()
    var time: Int = 60 {
        didSet {
            timeLabel.text = String(time)
        }
    }
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    var correctGuess: Int = 0
    var incorrectGuess: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //additional setup after view is loaded.
        startScreen()
        generateLabels()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startGameTimer),userInfo: nil, repeats: true)
    }
    
    //If no was tapped (checks answer).
    @IBAction func noTapped(_ sender: Any) {
        if potentialColors.firstIndex(of: meaningLabel.text!) !=   potentialUIColors.firstIndex( of: textColorLabel.textColor) {
            answerIndicator.text = "Good Job!"
            answerIndicator.textColor = UIColor.green
            score += 100
            correctGuess += 1
        } else {
            answerIndicator.text = "Oops, Incorrect!"
            answerIndicator.textColor = UIColor.red
            score -= 10
            incorrectGuess += 1
        }
        answerIndicator.isHidden = false
    
        // 1 sec delay for right/wrong indicator to display
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.generateLabels()
        }
    }
    
    // If yes was tapped (checks answer)
    @IBAction func yesTapped(_ sender: Any) {
        if potentialColors.firstIndex(of: meaningLabel.text!) == potentialUIColors.firstIndex(of: textColorLabel.textColor) {
            answerIndicator.text = "Great Job!"
            answerIndicator.textColor = UIColor.green
            score += 100
            correctGuess += 1
        } else {
            answerIndicator.text = "Wrong!"
            answerIndicator.textColor = UIColor.red
            score -= 100
            incorrectGuess += 1
        }
        answerIndicator.isHidden = false

        // 1 sec delay for right/wrong indicator to display
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.generateLabels()
        }
    }
    
    //Random Value for labels
    func generateLabels() {
        
        //Hide indicator after guess
        answerIndicator.isHidden = true
        
        let randomMeaning = Int.random(in: 0..<potentialColors.count)
        let randomTextColor = Int.random(in: 0..<potentialColors.count)
        let randomColor = Int.random(in: 0..<potentialUIColors.count)
        
        meaningLabel.text = potentialColors[randomMeaning]
        textColorLabel.text = potentialColors[randomTextColor]
        textColorLabel.textColor = potentialUIColors[randomColor]
    }

    //Count timer down by 1
    // display times up then play again/quit/ score
    @objc func startGameTimer() {
        time -= 1
        timeLabel.text = String(time)
        
        if time == 0 {
            timesUpScreen()
        }
    }

    //If player wants to play again
    @IBAction func playAgain(_ sender: Any) {
        startScreen()
        generateLabels()
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.startGameTimer), userInfo: nil, repeats: true)
    }

    //If player doesnt want to play anymore
    @IBAction func dontPlayAgain(_ sender: Any) {
    exit(0)
    }

    func startScreen() {
        noButton.isEnabled = true
        yesButton.isEnabled = true
        playAgainNoButton.isHidden = true
        playAgainYesButton.isHidden = true
        answerIndicator.isHidden = true
        titleLabel.text = "Does the top word match the color of the bottom word?"
        headerLabel.isHidden = false
        meaningLabel.isHidden = false
        textColorLabel.isHidden = false
        time = 60
        score = 0
        correctGuess = 0
        incorrectGuess = 0
    }
        
        func timesUpScreen() {
        noButton.isEnabled = false
        yesButton.isEnabled = false
        timer.invalidate()
        headerLabel.isHidden = true
        meaningLabel.isHidden = true
        textColorLabel.isHidden = true
        titleLabel.text = "Do you want to play again?"
        playAgainYesButton.isHidden = false
        playAgainNoButton.isHidden = false
        answerIndicator.text = "Times up!  Your score: \(score)\nYou got \(correctGuess) out of \(correctGuess + incorrectGuess)"
        answerIndicator.textColor = UIColor.white
        answerIndicator.isHidden = false
    }
}
