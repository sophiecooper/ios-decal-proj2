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
    
    @IBOutlet var IncorrectGuess: UIButton!
    
    @IBOutlet var HangmanIcon: UIImageView!
    
    @IBOutlet weak var GuessingTextField: UITextField!
    
    @IBOutlet weak var GuessingWord: UILabel!
    
    @IBOutlet weak var IncorrectLetters: UILabel!
    
    var IncorrectGuessedLetters = [String]()

    var Word : String = ""
    
    var phraseLetters : String = ""



    func GameOver() {
        print("game over")
        let alert = UIAlertController(title: "Game Over", message: "Try again!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        Word = phrase
        print(phrase)
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
    
    
    @IBAction func WrongGuess() {
        
        if wrongGuesses >= 6 {
            //make sure game is not over
            GuessingTextField.text = ""
            return
        }
        
        //make sure guess is valid
        let currGuess = GuessingTextField.text!.uppercaseString
        let currGuessvalue = String(currGuess)
        let num = currGuessvalue.unicodeScalars[currGuessvalue.unicodeScalars.startIndex].value
        
        //check if guess is valid
        if (currGuess.characters.count != 1) || (num < 65) || (num > 90 && num > 97) || (num > 122) {
            //invalid guess
            let alert = UIAlertController(title: "Invalid Guess", message: "Please input one letter", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            print("invalid guess")
            GuessingTextField.text = ""
            return
        }
        
        //make sure letter has not already been guessed
        if IncorrectGuessedLetters.count != 0 {
            for index in 0...IncorrectGuessedLetters.count-1 {
                if currGuess == IncorrectGuessedLetters[index] {
                    //letter has already been guessed, return
                    GuessingTextField.text = ""
                    return
                }
            }
        }
        
        let newCharIndex = Word.characters.indexOf(Character(currGuess))
        if newCharIndex == nil {
            IncorrectGuessedLetters.append(currGuess)
            wrongGuesses += 1
            HangmanIcon.image = UIImage(named: hangmanIcons[wrongGuesses])
            IncorrectLetters.text! += (String(currGuess) + ", ")
            GuessingTextField.text = ""
            if wrongGuesses >= 6 {
                GameOver()
                return
            }
        }
        
        //iterate through the word and insert the guessed letter if possible.
        var currChar = Word[Word.startIndex]
        var currPhraseLetter = phraseLetters[phraseLetters.startIndex]
        var modifiedWord = ""
        for x in 0...Word.characters.count-1 {
            currChar = Word[Word.startIndex.advancedBy(x)]
            currPhraseLetter = phraseLetters[phraseLetters.startIndex.advancedBy(x)]
            if currChar == Character(currGuess) {
                modifiedWord += currGuess
            } else {
                modifiedWord += String(currPhraseLetter)
            }
        }
        phraseLetters = modifiedWord
        GuessingWord.text = modifiedWord
        GuessingTextField.text = ""
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
