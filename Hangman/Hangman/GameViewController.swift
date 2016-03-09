//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let hangmanIcons = ["hangman1.gif", "hangman2.gif", "hangman3.gif", "hangman4.gif", "hangman5.gif", "hangman6.gif", "hangman7.gif"]
    var wrongGuesses = 0
    
    @IBOutlet var CorrectGuess: UIButton!
    
    @IBOutlet var IncorrectGuess: UIButton!
    
    @IBOutlet var HangmanIcon: UIImageView!
    
    @IBOutlet weak var GuessingTextField: UITextField!
    
    @IBOutlet weak var GuessingWord: UILabel!
    
    @IBOutlet weak var IncorrectLetters: UILabel!
    
    
    
    @IBAction func WrongGuess() {
        wrongGuesses += 1
        if wrongGuesses >= 7 {
            GameOver()
            return
        }
        print(wrongGuesses)
        HangmanIcon.image = UIImage(named: hangmanIcons[wrongGuesses])
    }

    func GameOver() {
        print("game over")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        var phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        var phraseLetters = ""
        HangmanIcon.image = UIImage(named: hangmanIcons[wrongGuesses])
        for character in phrase.characters {
            if character == " " {
                phraseLetters += String(character)
            } else {
                phraseLetters += "-"
            }
        }
        GuessingWord.text = phraseLetters
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //override func loadView() {
    //    IncorrectGuess.addTarget(self, action: "wrongGuess", forControlEvents: .TouchUpInside)
    //}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
